class RemoveNullFalseFromReservations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reservations, :guest_id, true
  end
end
