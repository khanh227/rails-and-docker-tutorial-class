class CreateLunchOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :lunch_orders do |t|
      t.date :order_date
      t.timestamps
    end
  end
end
