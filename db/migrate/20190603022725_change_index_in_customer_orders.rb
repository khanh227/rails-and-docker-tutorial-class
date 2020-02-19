class ChangeIndexInCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    remove_index :customer_orders, [:user_id, :menu_id]
    add_index :customer_orders, [:user_id, :menu_id], unique: true
  end
end
