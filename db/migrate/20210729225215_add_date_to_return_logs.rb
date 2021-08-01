class AddDateToReturnLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :return_logs, :date, :date
  end
end
