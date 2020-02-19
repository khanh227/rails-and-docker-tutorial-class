class Menu < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by'
  has_one_attached :background_img
  def products
    Product.where(id: product_ids)    
  end
end
