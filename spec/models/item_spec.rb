require 'rails_helper'

describe Item do
  context 'Validation' do
    it do
      should define_enum_for(:status)
        .with_values(available: 0, reserved: 5, dispatched: 10)
    end
  end
end
