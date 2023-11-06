class Inn < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, :city, :state, :postal_code, :description, :payment_methods, :usage_policy, :check_in, :check_out, :host_id, presence: true
  enum status: { inactive: 0, active: 2 }
  has_many :room
  belongs_to :host
end
