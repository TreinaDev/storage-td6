require 'rails_helper'

describe 'User register return log' do
  it 'successfully with one picture and is approved' do
    warehouse = create(:warehouse, code: 'abcd')
    user = create(:user, warehouse: warehouse)
    create(:product_entry, quantity: 1, warehouse: warehouse)
    reserve_log = create(:reserve_log, request_number: '123456', item: Item.last, sku: '1234')
    create(:return_entry, request_number: reserve_log.request_number, item_code: Item.last.code)

    login_as user, scope: :user
    visit root_path
    click_on 'Entrada de Devoluções'
    click_on '123456'
    click_on 'Cadastrar Log de Devolução'
    fill_in 'Data de devolução', with: Time.zone.today
    fill_in 'Justificativa', with: 'Produto está em boas condições'
    select 'Aprovado', from: 'Decisão'
    attach_file 'Foto', Rails.root.join('spec/fixture/foto1.jpg')
    click_on 'Criar Log de Devolução'

    expect(ReturnLog.count).to eq 1
    expect(page).to have_content '123456'
    expect(page).to have_content Item.last.code
    expect(page).to have_content I18n.l Time.zone.today
    expect(page).to have_content 'Produto está em boas condições'
    expect(page).to have_content 'Aprovado'
    expect(page).to have_css("img[src*='foto1.jpg']")
    expect(page).to have_link('Voltar', href: return_entries_path)
  end

  it 'successfully with one picture and is discarted' do
    warehouse = create(:warehouse, code: 'abcd')
    user = create(:user, warehouse: warehouse)
    create(:product_entry, quantity: 1, warehouse: warehouse)
    reserve_log = create(:reserve_log, request_number: '123456', item: Item.last, sku: '1234')
    create(:return_entry, request_number: reserve_log.request_number, item_code: Item.last.code)

    login_as user, scope: :user
    visit root_path
    click_on 'Entrada de Devoluções'
    click_on '123456'
    click_on 'Cadastrar Log de Devolução'
    fill_in 'Data de devolução', with: Time.zone.today
    fill_in 'Justificativa', with: 'Produto está em boas condições'
    select 'Descartado', from: 'Decisão'
    attach_file 'Foto', Rails.root.join('spec/fixture/foto1.jpg')
    click_on 'Criar Log de Devolução'

    expect(ReturnLog.count).to eq 1
    expect(page).to have_content '123456'
    expect(page).to have_content Item.last.code
    expect(page).to have_content I18n.l Time.zone.today
    expect(page).to have_content 'Produto está em boas condições'
    expect(page).to have_content 'Descartado'
    expect(page).to have_css("img[src*='foto1.jpg']")
    expect(page).to have_link('Voltar', href: return_entries_path)
  end

  it 'all fields must be filled' do
    warehouse = create(:warehouse, code: 'abdc')
    user = create(:user, warehouse: warehouse)
    create(:product_entry, quantity: 1, warehouse: warehouse)
    reserve_log = create(:reserve_log, request_number: '123456', item: Item.last, sku: 1234)
    create(:return_entry, request_number: reserve_log.request_number, item_code: Item.last.code)

    login_as user, scope: :user
    visit root_path
    click_on 'Devoluções'
    click_on '123456'
    click_on 'Cadastrar Log de Devolução'
    click_on 'Criar Log de Devolução'

    expect(ReturnLog.count).to be_zero
    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_link('Voltar', href: return_entries_path)
  end

  it 'must be logged in to register a return_log' do
    visit return_entries_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
