class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: true
      t.integer :group_size
      t.date :arrive_date
      t.date :leave_date
      t.integer :total_price
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
