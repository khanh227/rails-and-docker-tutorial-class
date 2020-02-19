class LunchOrder < ApplicationRecord
  has_many :customer_orders, dependent: :destroy
end
