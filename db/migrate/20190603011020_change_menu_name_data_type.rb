class ChangeMenuNameDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :menus, :menu_name, :string
  end
end
