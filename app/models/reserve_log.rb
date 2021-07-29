class ReserveLog < ApplicationRecord
  validates :item, :shipping_company, :request_number, :sku, presence: true
  belongs_to :item
end
