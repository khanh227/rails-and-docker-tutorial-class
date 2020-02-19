class ChangeColumnUserIdToCreatedByOnTableMenus < ActiveRecord::Migration[5.2]
  def change
    rename_column :menus, :user_id, :created_by
  end
end
