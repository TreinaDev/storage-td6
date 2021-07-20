class AddSkuToReserveLog < ActiveRecord::Migration[6.1]
  def change
    add_column :reserve_logs, :sku, :string
  end
end
