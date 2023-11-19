class ConfirmationController < ApplicationController
  def index
    @room = Room.find(session[:r]) if session[:r].present?
    @inn = Inn.find(session[:i]) if session[:i].present?
    @reservation = session[:res] if session[:res].present?
  end
  
  def create
    @inn = Inn.find(session[:i])
    @room = Room.find(session[:r])
    @reservation = session[:res]
    @reservation = @room.reservation.build(@reservation)
    @reservation.guest_id = current_guest.id
    @total_price = (@reservation["leave_date"].to_date - @reservation["arrive_date"].to_date).to_i * @room.price
    @reservation.total_price = @total_price
    if @reservation.save
      redirect_to  host_reservations_path(current_guest.id), notice: 'Reserva Cadastrada com sucesso.' 
      session.delete(:r)
      session.delete(:i)
      session.delete(:res)
    else
      flash.now[:notice] = 'Reserva não enviada.' 
      render 'new'
    end
  end

  private

  def reservation_params
    reservation_params = params.require(:reservation).permit(:room_id, :group_size, :arrive_date, :leave_date, :code)
  end
end
