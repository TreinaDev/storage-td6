require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:registration_code) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf) }
    it { should validate_uniqueness_of(:registration_code) }
    it { should define_enum_for(:role) }
    it { should allow_value('36898294024').for(:cpf) }
    it { should_not allow_value('3D898294024').for(:cpf) }
    it { should_not allow_value('31898294024').for(:cpf) }
    it { should validate_length_of(:cpf).is_equal_to(11) }
  end

end
