class RenameInnToInns < ActiveRecord::Migration[7.1]
  def change
    rename_table :inn, :inns
  end
end
