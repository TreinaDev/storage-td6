class CreateReturnLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :return_logs do |t|
      t.belongs_to :return_entry, null: false, foreign_key: true
      t.string :date
      t.text :justification
      t.integer :decision

      t.timestamps
    end
  end
end
