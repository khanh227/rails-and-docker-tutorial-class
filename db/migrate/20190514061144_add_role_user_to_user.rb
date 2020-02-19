class AddRoleUserToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role_user, :integer, null: false, default: 0
  end
end
