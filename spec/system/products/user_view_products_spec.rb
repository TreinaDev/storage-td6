require 'rails_helper'

describe 'User View Products' do
  it 'success' do
    create(:product, sku: 'a5d4g3t2d1')

    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'

    expect(current_path).to eq(products_path)
    expect(page).to have_content('Produtos')
    expect(page).to have_content('SKU: a5d4g3t2d1')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and there is none' do
    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'

    expect(current_path).to eq(products_path)
    expect(page).to have_content('Nenhum Produto Cadastrado')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and see details from product' do
    create(:product, sku: 'a5d4g3t2d1')

    login_as_user
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'a5d4g3t2d1'

    expect(current_path).to eq(product_path(Product.last))
    expect(page).to have_content('Produto')
    expect(page).to have_content('SKU: a5d4g3t2d1')
    expect(page).to have_link('Voltar', href: products_path)
  end

  it 'must be logged in to view products through route' do
    visit products_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to view details from a product through route' do
    product = create(:product)

    visit product_path(product)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
