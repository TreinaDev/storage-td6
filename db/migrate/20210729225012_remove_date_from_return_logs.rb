class RemoveDateFromReturnLogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :return_logs, :date, :string
  end
end
