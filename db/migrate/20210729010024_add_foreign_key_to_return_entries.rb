class AddForeignKeyToReturnEntries < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :return_entries, :items, column: :item_code, primary_key: :code
  end
end
