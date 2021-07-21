class Product < ApplicationRecord
  has_many :product_warehouses, dependent: :destroy
  has_many :warehouses, through: :product_warehouses
end
