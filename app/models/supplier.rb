class Supplier < ApplicationRecord
    has_many :addresses, as: :addressable
end
