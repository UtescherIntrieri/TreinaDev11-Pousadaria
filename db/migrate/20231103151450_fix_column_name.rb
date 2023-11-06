class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :inns, :corporate_names, :corporate_name
  end
end
