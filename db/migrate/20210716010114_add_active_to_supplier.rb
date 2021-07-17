class AddActiveToSupplier < ActiveRecord::Migration[6.1]
  def change
    add_column :suppliers, :active, :boolean
  end
end
