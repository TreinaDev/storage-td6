require 'rails_helper'

describe 'User block supplier' do
  it 'success' do
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)
    create(:supplier, name: 'Codeplay S.A.',
                      trade_name: 'Codeplay Vendas',
                      cnpj: '29.317.821/0001-38',
                      active: true)

    login_as user
    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A.'
    click_on 'Desativar Fornecedor'

    expect(Supplier.last.active).to eq(false)
    expect(page).to have_content('Bloqueado')
    expect(page).to have_content('Fornecedor alterado com sucesso!')
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('Codeplay Vendas')
    expect(page).to have_content('29.317.821/0001-38')
    expect(page).to_not have_content('Ativado')
  end

  it 'user active supplier' do
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)
    create(:supplier, name: 'Codeplay S.A.',
                      trade_name: 'Codeplay Vendas',
                      cnpj: '29.317.821/0001-38',
                      active: false)

    login_as user
    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A.'
    click_on 'Ativar Fornecedor'

    expect(Supplier.last.active).to eq(true)
    expect(page).to have_content('Ativado')
    expect(page).to have_content('Fornecedor alterado com sucesso!')
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('Codeplay Vendas')
    expect(page).to have_content('29.317.821/0001-38')
    expect(page).to_not have_content('Bloqueado')
  end
end
