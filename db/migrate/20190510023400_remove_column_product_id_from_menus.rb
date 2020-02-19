class RemoveColumnProductIdFromMenus < ActiveRecord::Migration[5.2]
  def change
    remove_column :menus, :product_id, :bigint
  end
end
