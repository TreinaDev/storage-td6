class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true
end
