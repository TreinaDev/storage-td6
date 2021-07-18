require 'rails_helper'

describe 'User Register a Product' do
  it 'success' do
    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'SKU', with: 'S1E2F3G4L5'
    click_on 'Criar Produto'

    expect(current_path).to eq(product_path(Product.last))
    expect(page).to have_content('SKU: S1E2F3G4L5')
    expect(page).to have_content('Produto Criado')
    expect(page).to have_link('Voltar', href: products_path)
  end

  it 'cannot be blank' do
    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Cadastrar Produto'
    click_on 'Criar Produto'

    expect(page).to have_content('não pode ficar em branco')
  end

  it 'must be uniqueness' do
    create(:product, sku: 'S1E2F3G4L5')

    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'SKU', with: 'S1E2F3G4L5'
    click_on 'Criar Produto'

    expect(page).to have_content('já está em uso')
    expect(page).to have_content('Não foi possível cadastrar o Produto')
  end

  it 'must be logged in to register a product through route' do
    visit products_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
