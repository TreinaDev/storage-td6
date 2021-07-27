require 'rails_helper'

describe 'User update supplier' do
  it 'should be logged in even on direct request' do
    get '/suppliers/:id/edit', params: {
      supplier: {
        name: 'Codeplay S.A',
        trade_name: 'Codeplay',
        cnpj: '42.122.917/9093-10',
        active: true
      }
    }

    expect(response).to redirect_to(new_user_session_path)
  end
end
