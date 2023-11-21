class ConfirmationController < ApplicationController
  def index
    @room = Room.find(session[:r]) if session[:r].present?
    @inn = Inn.find(session[:i]) if session[:i].present?
    @reservation = session[:res] if session[:res].present?
    @reservation["total_price"] = 0
    @adjusted_prices = AdjustedPrice.all.where(inn_id: @inn.id).where(room_id: @room.id)
    @reservation["total_price"] = (@reservation["leave_date"].to_date - @reservation["arrive_date"].to_date).to_i * @room.price
    range1 = Range.new(@reservation["arrive_date"], @reservation["leave_date"])
    (@reservation["arrive_date"]..@reservation["leave_date"]).first((@reservation["leave_date"].to_date - @reservation["arrive_date"].to_date).to_i).each do |date|
      @adjusted_prices.each do |ap|
        range2 = Range.new(ap.start_date, ap.end_date)
        if date.to_date.between?(ap.start_date, ap.end_date)
          @reservation["total_price"] += ap.price - @room.price
        end
      end
    end
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
      redirect_to  guest_path(current_guest.id), notice: 'Reserva Cadastrada com sucesso.' 
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
