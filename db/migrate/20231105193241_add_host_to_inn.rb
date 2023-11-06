class AddHostToInn < ActiveRecord::Migration[7.1]
  def change
    add_reference :inns, :host, null: false, foreign_key: true, default: 0
  end
end
