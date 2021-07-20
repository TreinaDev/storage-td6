class AddAttributesToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :sku, :string
    add_index :items, :sku, unique: true
    add_reference :items, :product_entry, null: false, foreign_key: true
    add_reference :items, :warehouse, null: false, foreign_key: true
  end
end
