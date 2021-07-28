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
    fill_in 'Endereço', with: 'Avenida Paulista'
    fill_in 'Número', with: '52'
    fill_in 'Bairro', with: 'Bela Vista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01310900'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content('Fornecedor editado!')
    expect(page).to have_content('Codeplay SA')
    expect(page).to have_content('CodePlay Vendas')
    expect(page).to have_content('42.122.917/9093-10')
    expect(page).to have_content('Avenida Paulista')
    expect(page).to have_content('52')
    expect(page).to have_content('Bela Vista')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('01310900')
    expect(page).to have_content('-23.5672582')
    expect(page).to have_content('-46.651529')
    expect(page).to have_link('Voltar', href: suppliers_path)
  end

  it 'and editing only number and zip code of address from supplier' do
    supplier = create(:supplier, name: 'Codeplay S.A.',
                                 trade_name: 'CodePlay',
                                 cnpj: '42.122.917/9093-10',
                                 active: true)
    create(:address, name: 'Avenida Paulista', number: 52,
                     district: 'Bela Vista', city: 'São Paulo',
                     state: 'SP', zip_code: '01310900',
                     addressable: supplier)

    login_as_user
    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A'
    click_on 'Editar Fornecedor'
    fill_in 'Número', with: '460'
    fill_in 'CEP', with: '01310904'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content('Fornecedor editado!')
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('CodePlay')
    expect(page).to have_content('42.122.917/9093-10')
    expect(page).to have_content('Avenida Paulista')
    expect(page).to have_content('460')
    expect(page).to have_content('Bela Vista')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('01310904')
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
