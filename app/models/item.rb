class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  enum status: { active: 0, reserved: 5, dispatched: 10 }
end
