class ChangeColumnNameInTables < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer_orders, :lunch_order_id, :menu_id
    remove_column :customer_orders, :product_id
    rename_column :menus, :menu_date, :menu_name
  end
end
