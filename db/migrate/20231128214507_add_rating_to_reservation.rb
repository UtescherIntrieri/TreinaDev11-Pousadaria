class AddRatingToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :rating, :integer
  end
end
