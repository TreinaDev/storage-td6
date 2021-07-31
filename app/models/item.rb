class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product_entry

  validates :code, :sku, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 10 }
  belongs_to :product
  has_many :reserve_logs, dependent: :destroy

  has_one :dispatch_log, dependent: :destroy
  has_many :return_entries,
           foreign_key: 'item_code', primary_key: 'code',
           inverse_of: :item, dependent: :destroy

  enum status: { available: 0, reserved: 5, dispatched: 10, discarted: 15 }

  scope :availables, -> { where(status: :available) }
  scope :reserveds, -> { where(status: :reserved) }
  scope :by_product, ->(product) { where(product: product) }

  def self.available_items(warehouse, product)
    availables.by_product(product).where('code LIKE ?', "%#{warehouse.code}%")
  end

  def self.first_item(warehouse, product)
    availables.by_product(product).find_by('code LIKE ? ', "%#{warehouse.code}%")
  end

  def save_log(params)
    reserved!
    reserve_logs.create(params)
  end
end
