class AddIndexToProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :sku, unique: true
  end
end
