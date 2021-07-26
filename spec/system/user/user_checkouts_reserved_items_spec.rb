require 'rails_helper'

describe 'User checkouts reserved item' do
  let(:warehouse) { create(:warehouse) }
  let(:user) { create(:user, role: 'user', warehouse: warehouse) }

  it 'successfully' do
    login_as user, scope: :user

    create(:item, status: 'reserved')

    visit root_path
    click_on 'Itens Reservados'
    click_on 'Despachar'

    fill_in 'Pessoa Autorizada', with: 'John Doe'
    expect { click_on 'Confirmar' }.to change { DispatchLog.count }.by(1)

    expect(Item.first.status).to eq('dispatched')
    expect(Item.first.dispatch_log.user.email).to eq(user.email)
    expect(Item.first.dispatch_log.authorized_person).to eq('John Doe')
  end
end
