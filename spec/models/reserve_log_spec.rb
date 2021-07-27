require 'rails_helper'

describe ReserveLog do
  context 'validations' do
    context 'presence' do
      it { should validate_presence_of(:item) }
      it { should validate_presence_of(:shipping_company) }
      it { should validate_presence_of(:request_number) }
      it { should validate_presence_of(:sku) }
    end

    context 'associations' do
      it { should belong_to(:item) }
    end
  end
end
