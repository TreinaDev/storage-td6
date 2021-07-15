class AddIndexCpfToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :cpf, unique: true
  end
end
