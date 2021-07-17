class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, length: { is: 18 }
  validates :cnpj, cnpj: true

  def switch_allowance
    self.active = !active
    save
  end
end
