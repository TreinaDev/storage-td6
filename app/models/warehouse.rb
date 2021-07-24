class Warehouse < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :code, uniqueness: true, length: { is: 4 }
  end

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :product_warehouses, dependent: :destroy
  has_many :products, through: :product_warehouses
  has_many :product_entries, dependent: :destroy

  def as_json(_options = {})
    {
      warehouse_code: code,
      lat: addresses.first.latitude,
      lon: addresses.first.longitude
    }
  end

  def to_ecommerce_json(quantity, _options = {})
    {
      warehouse_code: code,
      quantity: quantity
    }
  end
end
