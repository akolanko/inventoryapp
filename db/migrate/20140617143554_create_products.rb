class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :color
      t.string :material
      t.string :size
      t.text :measurements
      t.text :description
      t.integer :price
      t.integer :inventory
      t.boolean :soldout
      t.integer :category_id

      t.timestamps
    end
  end
end
