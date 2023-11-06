class DimensionChangeColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :rooms, :dimension, :integer
  end
end
