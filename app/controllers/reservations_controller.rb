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
  end
  
  def new
    time_overlap
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = @room.reservation.build()
  end

  def create
    time_overlap
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
  end

  def update
  end

  def activate
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.pending? && Time.now >= @reservation.arrive_date
      @reservation.arrived_at = Time.now
      @reservation.active!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end
  
  def finish
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.active?
      @reservation.left_at = Time.now
      @reservation.finished!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end
  
  def cancel
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.pending? && Time.now >= @reservation.arrive_date + 2.days
      @reservation.cancel!
    end
    redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id)
  end
  
  private

  def reservation_params
    reservation_params = params.require(:reservation).permit(:room_id, :group_size, :arrive_date, :leave_date, :code)
  end
end
