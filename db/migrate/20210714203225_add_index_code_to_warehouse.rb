class AddIndexCodeToWarehouse < ActiveRecord::Migration[6.1]
  def change
    add_index :warehouses, :code, unique: true
  end
end
