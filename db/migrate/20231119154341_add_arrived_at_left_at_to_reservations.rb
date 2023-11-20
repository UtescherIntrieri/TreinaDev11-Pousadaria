class AddArrivedAtLeftAtToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :arrived_at, :datetime
    add_column :reservations, :left_at, :datetime
  end
end
