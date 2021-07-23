class RemoveSkufromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :sku, :string
  end
end
