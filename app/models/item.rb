class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product_entry

  validates :code, :sku, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 10 }
end
