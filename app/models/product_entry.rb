require 'csv'
class ProductEntry < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :product

  has_many :items, dependent: :destroy

  validates :invoice, :sku, :quantity, presence: true
  validates :supplier, supplier_must_be_active: true

  before_validation :find_or_create_product
  after_create :create_items

  def quantity
    items.available.count
  end

  def self.import_from_csv(file, warehouse)
    csv = CSV.parse(File.read(file), headers: true)

    raise MustBeAValidCsv if csv.empty?

    entries = csv.map { |row| ProductEntry.new(**row.to_h, warehouse: warehouse) }
    return if entries.map(&:valid?).any?(false)

    entries.each(&:save)
  end

  private

  def create_items
    (1..quantity).each do
      item = items.new(sku: sku,
                       supplier: supplier,
                       warehouse: warehouse,
                       product: product)
      last_code = Item.where(warehouse: warehouse)&.last&.code
      item.code = generate_last_code(last_code)
      item.save
    end
  end

  def find_or_create_product
    self.product = Product.find_or_create_by(sku: sku)
  end

  def generate_last_code(last_code)
    return last_code.succ if last_code

    "#{warehouse.code}#{'1'.rjust(6, '0')}"
  end
end
