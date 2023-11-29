class AddCommentToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :comment, :string
  end
end
