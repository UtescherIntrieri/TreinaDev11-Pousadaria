class Inn < ApplicationRecord
  enum status: { inactive: 0, active: 2 }
end
