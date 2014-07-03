class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :price
      t.integer :shipping_cost
      t.integer :shipping_paid
      t.integer :tax
      t.string :through
      t.datetime :date
      t.integer :product_id

      t.timestamps
    end
  end
end
