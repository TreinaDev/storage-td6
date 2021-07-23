require 'rails_helper'

describe Item do
  context 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:sku) }
  end

  context 'uniqueness' do
    it 'must be uniq' do
      product = create(:product_entry)
      create(:item, code: 'abcd001111', warehouse: product.warehouse)
      item = build(:item, code: 'abcd001111')

      item.valid?

      expect(item.errors.messages[:code]).to include('já está em uso')
    end
  end

  context 'length' do
    it { should validate_length_of(:code).is_equal_to(10) }
  end
  context 'Enum' do
    it do
      should define_enum_for(:status)
        .with_values(available: 0, reserved: 5, dispatched: 10)
    end
  end
end
