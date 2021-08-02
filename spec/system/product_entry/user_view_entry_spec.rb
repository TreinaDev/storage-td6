require 'rails_helper'

describe 'User View Products Entry' do
  it 'success' do
    supplier = create(:supplier)
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)
    product = create(:product_entry, sku: 'abc1234', invoice: '654123',
                                     quantity: 7, supplier: supplier,
                                     warehouse: warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Entrada de Produtos')
    expect(page).to have_content('SKU')
    expect(page).to have_content('abc1234')
    expect(page).to have_content('Quantidade')
    expect(page).to have_content('7')
    expect(page).to have_content('Data de Entrada')
    expect(page).to have_content(product.created_at.strftime('%d/%m/%Y').to_s)
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and see details from product entry' do
    supplier = create(:supplier)
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)
    create(:product_entry, sku: 'abc1234', invoice: '654123',
                           quantity: 7, supplier: supplier,
                           warehouse: warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'abc1234'

    expect(page).to have_content('Entrada de Produto')
    expect(page).to have_content('SKU: abc1234')
    expect(page).to have_content('Quantidade: 7')
    expect(page).to have_content('Nota Fiscal: 654123')
    expect(page).to have_content('Código do Fornecedor: 1')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end

  it 'and there is none' do
    login_as_user
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Nenhuma Entrada de Produto')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'must be logged in to see a product entry' do
    visit product_entries_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to see from product entry through route' do
    visit product_entries_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to see details from product entry through route' do
    product = create(:product_entry)

    visit product_entry_path(product)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
