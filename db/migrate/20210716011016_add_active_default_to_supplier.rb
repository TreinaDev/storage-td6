class AddActiveDefaultToSupplier < ActiveRecord::Migration[6.1]
  def change
    change_column :suppliers, :active, :boolean, default: true
  end
end
