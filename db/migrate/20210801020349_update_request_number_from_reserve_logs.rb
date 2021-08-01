class UpdateRequestNumberFromReserveLogs < ActiveRecord::Migration[6.1]
  def change
    change_column :reserve_logs, :request_number, :string
  end
end
