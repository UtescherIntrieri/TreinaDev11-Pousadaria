class CreateAdjustedPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :adjusted_prices do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.references :room, null: false, foreign_key: true, default: 0

      t.timestamps
    end
  end
end
