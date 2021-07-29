class CreateDispatchLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dispatch_logs do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :authorized_person

      t.timestamps
    end
  end
end
