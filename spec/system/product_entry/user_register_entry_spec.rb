require 'rails_helper'

describe 'User register product entry' do
  it 'success' do
    create(:supplier)
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    fill_in 'SKU', with: 'abc123'
    fill_in 'Nota Fiscal', with: '123654'
    fill_in 'Quantidade', with: '10'
    fill_in 'Código do Fornecedor', with: '1'
    click_on 'Criar Entrada de Produto'

    expect(page).to have_content('abc123')
    expect(page).to have_content('123654')
    expect(page).to have_content('10')
    expect(page).to have_content('Código do Fornecedor: 1')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end

  it 'cannot be blank' do
    create(:supplier)
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    click_on 'Criar Entrada de Produto'

    expect(page).to have_content('Não foi possível cadastrar a entrada de produto')
    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('é obrigatório')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end

  it 'sku must be uniq' do
    entry = create(:product_entry, sku: 'abc123')
    user = create(:user, warehouse: entry.warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    fill_in 'SKU', with: 'abc123'
    fill_in 'Nota Fiscal', with: '123654'
    fill_in 'Quantidade', with: '10'
    fill_in 'Código do Fornecedor', with: '1'
    click_on 'Criar Entrada de Produto'

    expect(page).to have_content('Não foi possível cadastrar a entrada de produto')
    expect(page).to have_content('já está em uso')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end
end
