class CreateProductEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :product_entries do |t|
      t.string :sku
      t.string :invoice
      t.integer :quantity
      t.belongs_to :supplier, null: false, foreign_key: true
      t.belongs_to :warehouse, null: false, foreign_key: true

      t.timestamps
    end
    add_index :product_entries, :sku, unique: true
  end
end
