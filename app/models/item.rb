class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product_entry

  validates :code, :sku, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 10 }
  belongs_to :product

  has_one :dispatch_log

  enum status: { available: 0, reserved: 5, dispatched: 10 }

  scope :availables, -> { where(status: :available) }
  scope :reserveds, -> { where(status: :reserved) }
  scope :by_product, ->(product) { where(product: product) }

  def self.available_items(warehouse, product)
    availables.by_product(product).where('code LIKE ?', "%#{warehouse.code}%")
  end

  def save_log(params)
    reserved!
    reserve = ReserveLog.new(params)
    reserve.item = self
    reserve.save
  end
end
