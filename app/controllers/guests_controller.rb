class GuestsController < ApplicationController

  def show
    @reservations = Reservation.all.where(guest_id: current_guest.id) if guest_signed_in?
  end
end