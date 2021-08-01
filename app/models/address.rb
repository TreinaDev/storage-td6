class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :name, :district, :city, :state, :zip_code, presence: true
  validates :zip_code, numericality: { only_integer: true }
  validates :zip_code, length: { is: 8 }
  after_validation :geocode

  def as_json(options = {})
    json = super({ only: %i[name number district city state latitude longitude] }.merge options)
    json['address'] = json.delete('name')
    json
  end

  private

  geocoded_by :address

  def address
    [name, district, city, state].compact.join(', ')
  end
end
