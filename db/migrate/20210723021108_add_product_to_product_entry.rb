class AddProductToProductEntry < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_entries, :product, null: false, foreign_key: true
  end
end
