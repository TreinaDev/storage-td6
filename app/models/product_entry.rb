class ProductEntry < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse

  has_many :items, dependent: :destroy

  validates :invoice, :sku, :quantity, presence: true

  after_create :create_items

  private

  def create_items
    (1..quantity).each do
      item = Item.new(sku: sku,
                      product_entry: self,
                      supplier: supplier,
                      warehouse: warehouse)
      last_code = Item.last.code if Item.last && Item.where(warehouse: warehouse)
      item.code = generate_last_code(last_code)
      item.save
    end
  end

  def generate_last_code(last_code)
    if last_code
      last_code.succ
    else
      "#{warehouse.code}#{'1'.rjust(10 - warehouse.code.size, '0')}"
    end
  end
end
