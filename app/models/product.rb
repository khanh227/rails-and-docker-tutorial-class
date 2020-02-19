class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, optional: true
  belongs_to :category

  has_many :customer_orders

  validates :name, :description, :price, :quatity, presence: true

  scope :enabled, ->{ where(enabled: :true) }
end
