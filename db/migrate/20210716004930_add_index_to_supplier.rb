class AddIndexToSupplier < ActiveRecord::Migration[6.1]
  def change
    add_index :suppliers, :cnpj, unique: true
  end
end
