class CreateReserveLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :reserve_logs do |t|
      t.references :item, null: false, foreign_key: true
      t.string :shipping_company
      t.integer :request_number

      t.timestamps
    end
  end
end
