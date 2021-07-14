require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:trade_name) }
    it { should validate_uniqueness_of(:cnpj) }
  end
end
