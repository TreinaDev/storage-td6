class Warehouse < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :code, uniqueness: true, length: { is: 4 }
  end

  has_one :address, as: :addressable, dependent: :destroy
  has_many :product_warehouses, dependent: :destroy
  has_many :products, through: :product_warehouses
  has_many :product_entries, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :supplier, through: :items
  has_many :return_entries, through: :items

  def as_json(_options = {})
    {
      warehouse_code: code,
      **address.as_json
    }
  end

  def to_ecommerce_json(quantity, _options = {})
    {
      warehouse_code: code,
      quantity: quantity
    }
  end

  def to_ecommerce_with_address_json(_options = {})
    {
      code: code,
      full_address: address.as_json
    }
  end
end
