require 'rails_helper'

describe Item do
  context 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:sku) }
  end

  context 'uniqueness' do
    it 'must be uniq' do
      product = FactoryBot.create(:product_entry)
      FactoryBot.create(:item, code: 'abcd001111', warehouse: product.warehouse)
      item = Item.new(code: 'abcd001111')

      item.valid?

      expect(item.errors.messages[:code]).to include('já está em uso')
    end
  end

  context 'length' do
    it { should validate_length_of(:code).is_equal_to(10) }
  end
end
