class AddIndexToDispatchLog < ActiveRecord::Migration[6.1]
  def change
    add_column :dispatch_logs, :item, :string
    add_index :dispatch_logs, :item, unique: true
  end
end
