class AddStatusToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :status, :integer, default: 0
  end
end
