class RemoveItemsFromReturnEntries < ActiveRecord::Migration[6.1]
  def change
    remove_reference :return_entries, :item, null: false, foreign_key: true
  end
end
