class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.string :dimension
      t.integer :capacity
      t.integer :price
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :ac
      t.boolean :tv
      t.boolean :wardrobre
      t.boolean :safe_box
      t.boolean :accessible
      t.integer :status, default: 2

      t.timestamps
    end
  end
end
