class AddStatusToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :status, :integer, default: 2
  end
end
