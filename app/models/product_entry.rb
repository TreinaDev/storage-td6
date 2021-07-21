class ProductEntry < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse

  has_many :items, dependent: :destroy

  validates :invoice, :sku, :quantity, presence: true
  validates :sku, uniqueness: true

  after_create :create_items

  private

  def create_items
    (1..self.quantity).each do |item|
      item = Item.new(sku: self.sku,
                      product_entry: self,
                      supplier: self.supplier,
                      warehouse: self.warehouse)
      last_code = Item.last.code if Item.last && Item.where(warehouse: self.warehouse)
      item.code = generate_last_code(last_code)
      item.save
    end
  end

  def generate_last_code(last_code)
    if last_code
      last_code.succ
    else
      "#{self.warehouse.code}#{'1'.rjust(10 - self.warehouse.code.size, '0')}"
    end
  end
end
