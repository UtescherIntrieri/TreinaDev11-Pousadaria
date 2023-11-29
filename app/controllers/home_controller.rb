class HomeController < ApplicationController
  def index
    @all_inns = Inn.active
    @last_3_inns = @all_inns.last(3).reverse
    @inns = @all_inns.first(@all_inns.length - @last_3_inns.length)
    @rooms = Room.vacant
    @reservations = Reservation.where.not(rating: nil)
  end
end