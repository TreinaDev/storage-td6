class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :cnpj
      t.string :name
      t.string :trade_name

      t.timestamps
    end
  end
end
