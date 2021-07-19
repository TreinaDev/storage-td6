require 'rails_helper'

describe 'User Register a Supplier' do
  it 'success' do
    visit suppliers_path
    click_on 'Registrar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay'
    fill_in 'CNPJ', with: '41.617.980/0001-53'
    fill_in 'Endereço', with: 'Alameda Santos'
    fill_in 'Número', with: '1293'
    fill_in 'Bairro', with: 'Jardim Paulista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01419002'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('Fornecedor criado!')
    expect(page).to have_content('Codeplay SA')
    expect(page).to have_content('CodePlay')
    expect(page).to have_content('41.617.980/0001-53')
    expect(page).to have_content('Alameda Santos')
    expect(page).to have_content('1293')
    expect(page).to have_content('Jardim Paulista')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('01419002')
    expect(page).to have_content('-23.5672582')
    expect(page).to have_content('-46.651529')
    expect(page).to have_link('Voltar', href: suppliers_path)
  end

  it 'cannot be blank' do
    visit suppliers_path
    click_on 'Registrar Fornecedor'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('não pode ficar em branco', count: 8)
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
  end

  it 'cnpj have uniqueness' do
    create(:supplier, cnpj: '41.617.980/0001-53')

    visit suppliers_path
    click_on 'Registrar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay'
    fill_in 'CNPJ', with: '41.617.980/0001-53'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('já está em uso')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
  end

  it 'cnpj must be valid' do
    create(:supplier, cnpj: '41.617.980/0001-53')

    visit suppliers_path
    click_on 'Registrar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay'
    fill_in 'CNPJ', with: 'fasdfasdfasdf'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('deve ser válido')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
  end

  it 'cnpj must be valid' do
    create(:supplier, cnpj: '41.617.980/0001-53')

    visit suppliers_path
    click_on 'Registrar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay'
    fill_in 'CNPJ', with: '41.343.980/0001-53'
    click_on 'Criar Fornecedor'

    expect(page).to have_content('deve ser válido')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
  end
end
