class CreateCorporateNames < ActiveRecord::Migration[7.1]
  def change
    create_table :inn do |t|
      t.string :corporate_names
      t.string :brand_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :description
      t.string :payment_methods
      t.boolean :pet_friendly
      t.string :usage_policy
      t.time :check_in
      t.time :check_out

      t.timestamps
    end
  end
end
