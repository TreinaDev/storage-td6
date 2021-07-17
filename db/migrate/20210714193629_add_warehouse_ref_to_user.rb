class AddWarehouseRefToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :warehouse, foreign_key: true
  end
end
