class CreateTodayMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :today_menus do |t|
      t.date :menu_date, null: false
      t.integer :product_ids, array: true, default: []
      t.integer :user_id
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
