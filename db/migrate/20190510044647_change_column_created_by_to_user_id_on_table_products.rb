class ChangeColumnCreatedByToUserIdOnTableProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :created_by, :user_id
  end
end
