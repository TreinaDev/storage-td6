require 'rails_helper'

describe 'User register product entry' do
  it 'success' do
    create(:supplier)

    login_as_user
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
    expect(page).to have_content('Código do Fornecedor: 1')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end

  it 'cannot be blank' do
    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    click_on 'Criar Entrada de Produto'

    expect(page).to have_content('Não foi possível cadastrar a entrada de produto')
    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('é obrigatório')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end

  it 'must be logged in to register a product entry' do
    visit product_entries_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to register a product entry through route' do
    visit new_product_entry_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'must be logged in to register a product entry through request' do
    post '/product_entries', params: { product_entry:
                                        {
                                          sku: 1,
                                          invoice: 1,
                                          quantity: 10,
                                          supplier_id: 1,
                                          warehouse_id: 1
                                        } }

    expect(response).to redirect_to new_user_session_path
  end

  it 'must create items' do
    warehouse = create(:warehouse, code: 'abcd')
    supplier = create(:supplier)
    create(:product_entry, quantity: 10, warehouse: warehouse, supplier: supplier)

    expect(Item.count).to eq(10)
    expect(Item.last.code).to eq('abcd000010')
  end

  it 'and supplier must be active' do
    create(:supplier, active: false)

    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    fill_in 'SKU', with: 'abc123'
    fill_in 'Nota Fiscal', with: '123654'
    fill_in 'Quantidade', with: '10'
    fill_in 'Código do Fornecedor', with: '1'
    click_on 'Criar Entrada de Produto'

    expect(page).to have_content('Fornecedor está desativado, entrada de produto bloqueada')
    expect(Item.count).to eq 0
    expect(ProductEntry.count).to eq 0
  end
end
