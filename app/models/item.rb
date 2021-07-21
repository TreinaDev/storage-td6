class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product_entry
end
