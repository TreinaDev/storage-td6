class ProductEntry < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse

  has_many :items, dependent: :destroy

  validates :invoice, :sku, :quantity, presence: true
  validates :sku, uniqueness: true

  after_create :create_items

  def create_items
    #warehouse = Warehouse.find(self.warehouse_id)
    binding.pry
  end
end
