require 'rails_helper'

describe 'User Register a Supplier' do
  it 'success' do
    visit suppliers_path
    click_on 'Registrar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay'
    fill_in 'CNPJ', with: '41.617.980/0001-53'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('Fornecedor criado!')
    expect(page).to have_content('Codeplay SA')
    expect(page).to have_content('CodePlay')
    expect(page).to have_content('41.617.980/0001-53')
    expect(page).to have_link('Voltar', href: suppliers_path)
  end

  it 'cannot be blank' do

    visit suppliers_path
    click_on 'Registrar Fornecedor'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
  end

end