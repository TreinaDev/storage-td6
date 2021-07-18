class Product < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
end
