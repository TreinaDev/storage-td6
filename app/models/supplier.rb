class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true

  def switch_allowance
    self.active = !active
    save
  end
end
