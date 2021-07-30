class CreateReturnEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :return_entries do |t|
      t.integer :request_number
      t.belongs_to :item, null: false, foreign_key: true
      t.string :item_code

      t.timestamps
    end
    add_index :return_entries, :request_number
    add_index :return_entries, :item_code
  end
end
