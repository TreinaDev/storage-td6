class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  enum status: { available: 0, reserved: 5, dispatched: 10 }

  scope :availables, -> { where(status: :available) }

  def self.available_items(warehouse, product)
    availables.where('code LIKE ? and product_id = ?', "%#{warehouse.code}%", product.id)
  end
end
