class CreateCustomerOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_orders do |t|
      t.integer :user_id
      t.integer :lunch_order_id
      t.integer :product_id
      t.datetime :canceled_at, default: nil
      t.index [:user_id, :lunch_order_id], unique: true
      t.timestamps
    end
  end
end
