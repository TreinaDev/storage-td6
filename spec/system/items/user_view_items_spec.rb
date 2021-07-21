require 'rails_helper'

describe 'User View Items' do
  it 'success' do
    supplier = create(:supplier)
    warehouse = create(:warehouse, code: 'abcd')
    user = create(:user, warehouse: warehouse)
    create(:product_entry, sku: 'abc1234', invoice: '654123',
                           quantity: 4, supplier: supplier,
                           warehouse: warehouse)

    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'abc1234'

    expect(page).to have_content('Entrada de Produto')
    expect(page).to have_content('SKU: abc1234')
    expect(page).to have_content('Quantidade: 4')
    expect(page).to have_content('abcd000001')
    expect(page).to have_content('abcd000002')
    expect(page).to have_content('abcd000003')
    expect(page).to have_content('abcd000004')
    expect(page).to have_link('Voltar', href: product_entries_path)
  end
end
