class Warehouse < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :code, uniqueness: true, length: { is: 4 }
  end

  has_many :addresses, as: :addressable
end
