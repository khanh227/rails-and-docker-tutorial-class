#Add user_id to product to identify who create product, 
#and user who create product can delete, edit their own products
class AddUserIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :user_id, :integer
  end
end
