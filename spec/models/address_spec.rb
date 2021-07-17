require 'rails_helper'

describe Address do
  context 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:district) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zip_code) }
    end

    context 'zip_code' do
      it { should allow_value('12345678').for(:zip_code) }
      it { should_not allow_value('12345-678').for(:zip_code) }
      it { should_not allow_value('12.345-678').for(:zip_code) }
      it { should_not allow_value('12345D78').for(:zip_code) }
      it { should validate_length_of(:zip_code).is_equal_to(8) }
      it { should validate_numericality_of(:zip_code) }
    end
  end
end