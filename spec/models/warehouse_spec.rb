require 'rails_helper'

describe Warehouse do
  context 'Validation' do
    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:code).with_message('não pode ficar em branco') }
    it { should validate_uniqueness_of(:code) }
  end
end
