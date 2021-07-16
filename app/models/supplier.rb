class Supplier < ApplicationRecord
  validates :name, :cnpj, :trade_name, presence: true
  validates :cnpj, uniqueness: true

  def set_active
    if self.active?
      self.active = false
    else
      self.active = true
    end
    self.save
  end
end
