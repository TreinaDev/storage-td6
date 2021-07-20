require 'rails_helper'

describe ProductEntry do
  context 'Validations' do
    it { should validate_presence_of(:sku) }
    it { should validate_presence_of(:invoice) }
    it { should validate_presence_of(:quantity) }
  end
  context 'uniqueness' do
    it {
      FactoryBot.create(:product_entry)
      should validate_uniqueness_of(:sku)
    }
  end
  context 'Associations' do
    it { should belong_to(:warehouse) }
    it { should belong_to(:supplier) }
    it { should have_many(:items) }
  end
end
