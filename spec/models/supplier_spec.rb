require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:trade_name) }
    it { should validate_uniqueness_of(:cnpj) }
  end
  describe 'cnpj' do
    it { should allow_value('29.317.821/0001-38').for(:cnpj) }
    it { should_not allow_value('44.323.255/1233-41').for(:cnpj) }
    it 'must be valid' do
      invalid_cnpj = '29.212.453/0001-38'
      should_not allow_value(invalid_cnpj).for(:cnpj)
    end
    it { should validate_length_of(:cnpj).is_equal_to(18) }
  end
end
