class ChangeDataTypeForShippingPaid < ActiveRecord::Migration
  def change
  	change_column :sales, :shipping_paid, :float
  end
end
