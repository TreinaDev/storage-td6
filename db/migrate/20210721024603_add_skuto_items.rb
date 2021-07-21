class AddSkutoItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :sku, :string
    add_index :items, :sku
  end
end
