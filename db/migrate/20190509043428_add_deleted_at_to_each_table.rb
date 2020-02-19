class AddDeletedAtToEachTable < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :deleted_at, :datetime
    add_column :products, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
  end
end
