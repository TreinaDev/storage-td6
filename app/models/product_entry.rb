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

  def self.convert_csv(params)
    csv = CSV.parse(File.read(params[:product_entry][:csv]), :headers => true)
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
    self.product = Product.create_with(sku: sku).find_or_create_by(sku: sku)
  end
    
  def generate_last_code(last_code)
    return last_code.succ if last_code
    
    "#{warehouse.code}#{'1'.rjust(6, '0')}"
  end

  def self.create_object_from_csv(csv, warehouse)
    valid_entries = []
    csv.each do |row|
      entry = ProductEntry.new(row.to_h)
      entry.warehouse = warehouse
      if entry.valid?
        valid_entries << entry
      else
        return false
      end
    end
    return valid_entries
  end
  
  def self.save_entry(valid_entries)
    valid_entries.each do |valid_entry|
      valid_entry.save
    end
  end
end
