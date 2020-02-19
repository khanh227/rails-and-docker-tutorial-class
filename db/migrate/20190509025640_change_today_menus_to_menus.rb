class ChangeTodayMenusToMenus < ActiveRecord::Migration[5.2]
  def change
    rename_table :today_menus, :menus 
  end
end
