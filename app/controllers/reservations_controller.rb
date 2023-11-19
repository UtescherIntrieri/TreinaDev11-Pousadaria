class ReservationsController < ApplicationController

  def index
    @host = Host.find(params[:host_id])
    @inn = Inn.find_by host_id: @host.id
    @rooms = Room.all.where(inn_id: @inn.id) if @inn.present?
    @reservations = Reservation.all.where(room_id: @rooms.ids)
    redirect_to(root_path) unless host_signed_in? && current_host.id == @host.id
  end

  def show
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
  end

  def update
  end

  private

  def reservation_params
    reservation_params = params.require(:reservation).permit(:room_id, :group_size, :arrive_date, :leave_date, :code)
  end
end
