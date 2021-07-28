require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validations' do
    it { should validate_uniqueness_of(:sku) }
  end
  context 'Associations' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:product_warehouses).dependent(:destroy) }
    it { should have_many(:warehouses) }
    it { should have_many(:product_entries).dependent(:destroy) }
  end
end
