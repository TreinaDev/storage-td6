require 'rails_helper'

describe ProductWarehouse do
  context 'validations' do
    context 'presence' do
      it { should validate_presence_of(:product) }
      it { should validate_presence_of(:warehouse) }
    end
    context 'uniqueness' do
      let(:product) { create(:product) }
      let(:warehouse) { create(:warehouse) }

      it 'should validate uniqueness of' do
        create(:product_warehouse, product: product, warehouse: warehouse)

        pw = ProductWarehouse.new(product: product, warehouse: warehouse)
        pw.valid?

        expect(pw.errors.messages[:warehouse]).to include('já está em uso')
        expect(pw.errors.messages[:product]).to include('já está em uso')
      end
    end
  end
end
