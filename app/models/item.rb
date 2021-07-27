class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product_entry

  validates :code, :sku, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 10 }
  belongs_to :product
  has_many :reserve_logs, dependent: :destroy

  enum status: { available: 0, reserved: 5, dispatched: 10 }

  scope :availables, -> { where(status: :available) }
  scope :by_product, ->(product) { where(product: product) }

  def self.available_items(warehouse, product)
    availables.by_product(product).where('code LIKE ?', "%#{warehouse.code}%")
  end

  def self.first_item(warehouse, product)
    availables.by_product(product).find_by('code LIKE ? ', "%#{warehouse.code}%")
  end

  def save_log(params)
    reserved!
    reserve = ReserveLog.new(params)
    reserve.save
  end
end
