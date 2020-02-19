class Category < ApplicationRecord
  acts_as_paranoid

  has_many :products

  validates :name, presence: true, length: { minimum: 5 }

  scope :enabled, ->{ where(enabled: :true) }
end
