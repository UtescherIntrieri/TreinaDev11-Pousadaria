class AddInnToAdjustedPrice < ActiveRecord::Migration[7.1]
  def change
    add_reference :adjusted_prices, :inn, null: false, foreign_key: true, default: 0
  end
end
