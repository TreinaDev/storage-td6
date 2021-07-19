class ProductEntry < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
end
