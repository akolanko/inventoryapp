class ChangeDataTypeForShippingCost < ActiveRecord::Migration
  def change
  	change_column :sales, :shipping_cost, :float
  end
end
