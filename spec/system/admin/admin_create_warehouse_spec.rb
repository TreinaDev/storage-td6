require 'rails_helper'

describe 'Admin should create Warehouse' do
  it 'succesffully' do
    visit root_path
    click_on 'Criar Galpões'

    fill_in 'Código', with: 'aeio'
    fill_in 'Nome', with: 'Galpão 1'
    fill_in 'Name', with: 'Rua Cinco'
    fill_in 'Number', with: '7'
    fill_in 'District', with: 'Nossa Senhora'
    fill_in 'City', with: 'Campinas'
    fill_in 'State', with: 'São Paulo'
    fill_in 'Zip code', with: '12345789'
    
    click_on 'Criar Galpão'

    expect(page).to have_content('Galpão 1')
    expect(page).to have_content('aeio')
    expect(page).to have_content('Galpão cadastrado com sucesso')
    expect(page).to have_content('Rua Cinco')
    expect(page).to have_content('7')
    expect(page).to have_content('Nossa Senhora')
    expect(page).to have_content('Campinas')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('12345789')
  end

  it 'code must be unique' do
    create(:warehouse)

    visit root_path
    click_on 'Criar Galpões'

    fill_in 'Código', with: 'code'
    fill_in 'Nome', with: 'Galpão 1'
    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('já está em uso')
  end

  it 'code must be 4 characters long' do
    visit root_path
    click_on 'Criar Galpões'

    fill_in 'Código', with: 'aeiou'
    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('Código não possui o tamanho esperado')
  end

  it 'and fields should not be blank' do
    visit root_path
    click_on 'Criar Galpões'

    click_on 'Criar Galpão'

    expect(page).to have_content('Novo Galpão')
    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and return to home page' do
    visit root_path
    click_on 'Criar Galpões'

    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
