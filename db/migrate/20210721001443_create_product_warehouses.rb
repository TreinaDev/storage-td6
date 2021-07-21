class CreateProductWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :product_warehouses do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :product_warehouses, [:product_id, :warehouse_id], unique: true
  end
end
