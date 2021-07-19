class RemoveInvoiceFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :invoice, :string
  end
end
