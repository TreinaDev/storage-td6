class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :name, :district, :city, :state, :zip_code, presence: true
  validates :zip_code, numericality: { only_integer: true }
  validates :zip_code, length: { is: 8 }
  after_validation :geocode

  private

  geocoded_by :address

  def address
    [name, district, city, state].compact.join(', ')
  end
end
