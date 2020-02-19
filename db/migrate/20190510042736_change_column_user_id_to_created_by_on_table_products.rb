class ChangeColumnUserIdToCreatedByOnTableProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :user_id, :created_by
  end
end
