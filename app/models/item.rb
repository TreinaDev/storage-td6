class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  enum status: { available: 0, reserved: 5, dispatched: 10 }

  scope :availables, -> { where(status: :available) }
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
