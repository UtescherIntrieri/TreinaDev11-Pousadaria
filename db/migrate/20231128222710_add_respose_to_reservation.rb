class AddResposeToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :response, :string
  end
end
