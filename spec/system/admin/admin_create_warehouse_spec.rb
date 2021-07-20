require 'rails_helper'

describe 'Admin should create Warehouse' do
  it 'succesffully' do
    login_as_admin
    visit root_path
    click_on 'Criar Galpões'
    fill_in 'Código', with: 'aeio'
    fill_in 'Nome', with: 'Galpão 1'
    fill_in 'Endereço', with: 'Alameda Santos'
    fill_in 'Número', with: '1293'
    fill_in 'Bairro', with: 'Jardim Paulista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01419002'

    click_on 'Criar Galpão'

    expect(page).to have_content('Galpão 1')
    expect(page).to have_content('aeio')
    expect(page).to have_content('Galpão cadastrado com sucesso')
    expect(page).to have_content('Alameda Santos')
    expect(page).to have_content('1293')
    expect(page).to have_content('Jardim Paulista')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('01419002')
    expect(page).to have_content('-23.5672582')
    expect(page).to have_content('-46.651529')
  end

  it 'code must be unique' do
    create(:warehouse)

    login_as_admin
    visit root_path
    click_on 'Criar Galpões'
    fill_in 'Código', with: 'code'
    fill_in 'Nome', with: 'Galpão 1'
    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('já está em uso')
  end

  it 'code must be 4 characters long' do
    login_as_admin
    visit root_path
    click_on 'Criar Galpões'
    fill_in 'Código', with: 'aeiou'
    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('Código não possui o tamanho esperado')
  end

  it 'and fields should not be blank' do
    login_as_admin
    visit root_path
    click_on 'Criar Galpões'
    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('não pode ficar em branco', count: 7)
  end

  it 'and return to home page' do
    login_as_admin
    visit root_path
    click_on 'Criar Galpões'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  it 'must be logged in to register a warehouse' do
    visit root_path
    click_on 'Criar Galpões'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to register a warehouse through route' do
    visit new_warehouse_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
