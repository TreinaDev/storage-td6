class ChangeColumnForUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.change :role, :integer, default: 0
    end
  end
end
