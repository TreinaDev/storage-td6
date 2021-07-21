require 'rails_helper'

describe 'Admin logged Warehouse' do
  it 'should be logged in even on direct request' do
    post '/warehouses', params: { warehouses: { code: '1236', name: 'Galpão 1' } }

    expect(response).to redirect_to new_user_session_path
  end
end
