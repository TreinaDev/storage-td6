class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true

  def set_active
    self.active = !(self.active)
    save
  end
end
