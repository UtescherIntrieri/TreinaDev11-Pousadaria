class ReservationsController < ApplicationController

  def index
    @host = Host.find(params[:host_id])
    @inn = Inn.find_by host_id: @host.id
    @rooms = Room.all.where(inn_id: @inn.id) if @inn.present?
    @reservations = Reservation.all.where(room_id: @rooms.ids)
    redirect_to(root_path) unless host_signed_in? && current_host.id == @host.id
  end

  def show
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if host_signed_in? || guest_signed_in?
      unless current_guest.id == @reservation.guest_id || current_host.id == @reservation.room.host_id 
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  
  def new
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = @room.reservation.build()
  end

  def create
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = @room.reservation.build(reservation_params)
    if @reservation.valid?
      session[:res] = @reservation
      session[:i] = @inn.id
      session[:r] = @room.id
      redirect_to confirmation_index_path, notice: 'Reserva enviada com sucesso.' 
    else
      flash.now[:notice] = 'Reserva não enviada.' 
      render 'reservations/new'
    end
  end

  def edit
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = @room.reservation.build()
  end

  def update
    @inn = Inn.find(params[:inn_id])
    @host = Host.find(@inn.host_id)
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.update reservation_params
      @reservation.save
      if guest_signed_in?
        redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id), notice: 'Avaliação enviada com sucesso.' 
      elsif host_signed_in?
        redirect_to review_show_host_reservation_path(@host.id, @reservation.id), notice: 'Resposta enviada com sucesso.' 
      end
    else
      flash.now[:notice] = 'Avaliação não enviada.' 
      render 'reservations/show'
    end
  end

  def activate
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.pending? && Time.now >= @reservation.arrive_date && current_host.id == @inn.host_id?
      @reservation.arrived_at = Time.now
      @reservation.active!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end
  
  def finish
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @adjusted_prices = AdjustedPrice.all.where(inn_id: @inn.id).where(room_id: @room.id)
    @reservation = Reservation.find(params[:id])
    if @reservation.active && current_host.id == @inn.host_id?
      @reservation.left_at = Time.now

      @reservation.total_price = (@reservation.left_at.to_date - @reservation.arrive_date.to_date).to_i * @room.price
      range1 = Range.new(@reservation.arrive_date, @reservation.left_at) 
      (@reservation.arrive_date..@reservation.left_at).first((@reservation.left_at.to_date - @reservation.arrive_date.to_date).to_i).each do |date| 
        @adjusted_prices.each do |ap| 
          range2 = Range.new(ap.start_date, ap.end_date) 
          if date.to_date.between?(ap.start_date, ap.end_date) 
            @reservation.total_price += ap.price - @room.price
          end 
        end 
      end 
      @reservation.finished!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end
  
  def cancel
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.pending? && ((host_signed_in? && Time.now >= @reservation.arrive_date + 2.days) || (guest_signed_in? && Time.now <= @reservation.arrive_date - 7.days))
    @reservation.cancel!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end

  def review_show
    @host = Host.find(params[:host_id])
    @inn =  Inn.find_by host_id: @host.id
    @reservation = Reservation.find(params[:id])
    @room = Room.find_by id: @reservation.room_id if @inn.present?
  end


  private

  def reservation_params
    reservation_params = params.require(:reservation).permit(:room_id, :group_size, :arrive_date, :leave_date, :code, :rating, :comment, :response)
  end
end
