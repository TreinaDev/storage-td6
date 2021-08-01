require 'rails_helper'

describe DispatchLog do
  context 'validations' do
    context 'presence' do
      it { should validate_presence_of(:item) }
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:authorized_person) }
    end

    context 'associations' do
      it { should belong_to(:item) }
      it { should belong_to(:user) }
    end
  end
end
