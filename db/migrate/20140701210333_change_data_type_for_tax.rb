class ChangeDataTypeForTax < ActiveRecord::Migration
  def change
  	change_column :sales, :tax, :float
  end
end
