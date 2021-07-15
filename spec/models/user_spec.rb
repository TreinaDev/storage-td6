require 'rails_helper'

describe User do
  context 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:role) }
      it { should validate_presence_of(:registration_code) }
      it { should validate_presence_of(:cpf) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:cpf) }
      it { should validate_uniqueness_of(:registration_code) }
    end

    context 'enum' do
      it { should define_enum_for(:role).with_values([:user, :admin]) }
    end

    context 'cpf' do
      it { should allow_value('36898294024').for(:cpf) }
      it { should_not allow_value('3D898294024').for(:cpf) }
      it do
        invalid_cpf = '31898294024'
        should_not allow_value(invalid_cpf).for(:cpf)
      end
      it { should validate_length_of(:cpf).is_equal_to(11) }
    end

    context 'email' do
      it { should allow_value('exemplo@mercadores.com.br').for(:email) }
      it { should_not allow_value('exemplo@mercadoes.com.br').for(:email) }
      it { should_not allow_value('exemplo@mercadores.com').for(:email) }
    end

    context 'password' do
      it 'password must be equal cpf' do
        warehouse = create(:warehouse)
        user = create(:user, cpf: CPF.generate, warehouse: warehouse)
        expect(user.password).to eq(user.cpf)
      end
    end
  end

  context 'on create' do
    it 'default role is user' do
      user = User.new
      expect(user.role).to eq('user')
    end
  end

  context 'as user' do
    before { allow(subject).to receive(:user?).and_return(true) }
    it { should validate_presence_of(:warehouse) }
  end

  context 'as admin' do
    before { allow(subject).to receive(:user?).and_return(false) }
    it { should_not validate_presence_of(:warehouse) }
  end

  # TODO: Refatorar usando !let
end
