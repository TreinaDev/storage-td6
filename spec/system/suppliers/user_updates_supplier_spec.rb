require 'rails_helper'

describe 'User Updates a Supplier' do
  it 'success' do
    supplier = create(:supplier, name: 'Codeplay S.A.',
                                 trade_name: 'Codeplay',
                                 cnpj: '42.122.917/9093-10',
                                 active: true)
    create(:address, name: 'Alameda Santos', number: 1293,
                     district: 'Jardim Paulista', city: 'São Paulo',
                     state: 'SP', zip_code: '01419002',
                     addressable: supplier)

    login_as_user
    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A'
    click_on 'Editar Fornecedor'
    fill_in 'Razão Social', with: 'Codeplay SA'
    fill_in 'Nome Fantasia', with: 'CodePlay Vendas'
    fill_in 'CNPJ', with: '42.122.917/9093-10'
    fill_in 'Endereço', with: 'Alameda Santos'
    fill_in 'Número', with: '1293'
    fill_in 'Bairro', with: 'Jardim Paulista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01419002'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content('Fornecedor editado!')
    expect(page).to have_content('Codeplay SA')
    expect(page).to have_content('CodePlay Vendas')
    expect(page).to have_content('42.122.917/9093-10')
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

  it 'must be logged in to update a supplier through route' do
    supplier = create(:supplier, name: 'Codeplay S.A.',
                                 trade_name: 'Codeplay',
                                 cnpj: '42.122.917/9093-10',
                                 active: true)

    visit edit_supplier_path(supplier)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
