class CreateCustomerOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_order_items do |t|
      t.integer :customer_order_id
      t.integer :product_id
      t.integer :quatity
      t.timestamps
    end
  end
end
