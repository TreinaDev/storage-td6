class ProductWarehouse < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product

  validates :warehouse, :product, presence: true
  validates :warehouse, uniqueness: { scope: :product }
  validates :product, uniqueness: { scope: :warehouse }
end
