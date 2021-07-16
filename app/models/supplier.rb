class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true

  def set_active
    active? ? self.active = false : self.active = true
    save
  end
end
