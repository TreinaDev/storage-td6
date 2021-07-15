require 'rails_helper'

describe 'User View Suppliers' do  
  it 'success' do
    supplier1 = create(:supplier)
    supplier2 = create(:supplier, cnpj: '41.628.980/0001-53')
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content(supplier1.name)
    expect(page).to have_content(supplier1.trade_name)
    expect(page).to have_content(supplier1.cnpj)
    expect(page).to have_content(supplier2.name)
    expect(page).to have_content(supplier2.trade_name)
    expect(page).to have_content(supplier2.cnpj)
    expect(page).to have_link('Voltar', href: root_path)
  end
end
