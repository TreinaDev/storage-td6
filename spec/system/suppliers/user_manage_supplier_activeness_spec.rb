require 'rails_helper'

describe 'User block supplier' do
  it 'success' do
    supplier = create(:supplier)

    visit root_path
    click_on 'Fornecedores'
    click_on supplier.name
    click_on 'Desativar Fornecedor'

    expect(Supplier.last.active).to eq(false)
    expect(page).to have_content('Bloqueado')
    expect(page).to have_content('Fornecedor alterado com sucesso!')
    expect(page).to have_content(supplier.name)
    expect(page).to have_content(supplier.trade_name)
    expect(page).to have_content(supplier.cnpj)
    expect(page).to_not have_content('Ativado')
  end

  it 'user active supplier' do
    supplier = create(:supplier, active: false)

    visit root_path
    click_on 'Fornecedores'
    click_on supplier.name
    click_on 'Ativar Fornecedor'

    expect(Supplier.last.active).to eq(true)
    expect(page).to have_content('Ativado')
    expect(page).to have_content('Fornecedor alterado com sucesso!')
    expect(page).to have_content(supplier.name)
    expect(page).to have_content(supplier.trade_name)
    expect(page).to have_content(supplier.cnpj)
    expect(page).to_not have_content('Bloqueado')
  end
end