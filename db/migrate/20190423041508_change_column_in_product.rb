#validate if insert null to these columns: name, description, price, quatity
#Set default enabled true when create product
class ChangeColumnInProduct < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:products, :name, false)
    change_column_null(:products, :description, false)
    change_column_null(:products, :price, false)
    change_column_default(:products, :enabled, true)
    change_column_null(:products, :quatity, false)
  end
end
