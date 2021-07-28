require 'rails_helper'

describe 'User checkouts reserved item' do
  let(:warehouse) { create(:warehouse, code: 'yyyy') }
  let(:user) { create(:user, role: 'user', warehouse: warehouse) }

  it 'successfully' do
    create(:product_entry, warehouse: warehouse)
    Item.first.reserved!

    login_as user, scope: :user
    visit root_path
    click_on 'Itens Reservados'
    click_on 'Despachar'

    fill_in 'Pessoa autorizada para retirada', with: 'John Doe'
    expect { click_on 'Confirmar' }.to change { DispatchLog.count }.by(1)

    expect(Item.first.status).to eq('dispatched')
    expect(Item.first.dispatch_log.user.email).to eq(user.email)
    expect(Item.first.dispatch_log.authorized_person).to eq('John Doe')
  end

  it 'should not view dispatch link' do
    create(:product_entry)

    login_as user, scope: :user
    visit root_path
    click_on 'Itens Reservados'

    expect(page).not_to have_link('Despachar')
    expect(page).not_to have_content(Item.last.code)
  end

  it 'unauthenticated user cannot view page' do
    visit root_path

    expect(page).not_to have_link('Itens Reservados')
  end

  it 'cannot create if not signed in' do
    create(:product_entry, warehouse: warehouse)
    visit new_item_dispatch_log_path(Item.first)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'should only view users warehouse items' do
    warehouse2 = create(:warehouse, code: 'xxxx')
    create(:product_entry, warehouse: warehouse2, quantity: 3)
    create(:product_entry, warehouse: warehouse, quantity: 3)
    Item.all.each(&:reserved!)

    login_as user, scope: :user

    visit root_path
    click_on 'Itens Reservados'

    expect(page).not_to have_content('xxxx000001')
    expect(page).not_to have_content('xxxx000002')
    expect(page).not_to have_content('xxxx000003')
    expect(page).to have_content('yyyy000001')
    expect(page).to have_content('yyyy000002')
    expect(page).to have_content('yyyy000003')
    expect(page).to have_link('Despachar', count: 3)
  end
end
