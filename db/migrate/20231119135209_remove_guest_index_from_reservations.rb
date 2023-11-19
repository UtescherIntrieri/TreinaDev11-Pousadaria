class RemoveGuestIndexFromReservations < ActiveRecord::Migration[7.1]
  def change
    remove_index "reservations", column: [:guest_id], name: "index_reservations_on_guest_id"
  end
end
