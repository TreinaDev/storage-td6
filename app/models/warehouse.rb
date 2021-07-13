class Warehouse < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true, presence: true
end
