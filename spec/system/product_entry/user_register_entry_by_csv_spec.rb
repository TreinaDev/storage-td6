require 'rails_helper'

describe 'User register Product Entr by csv' do
  it 'successfully' do
    create(:supplier)

    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    attach_file 'Arquivo CSV', Rails.root.join('spec/fixture/entry.csv')
    click_on 'Enviar arquivo'

    expect(current_path).to eq(product_entries_path)
    expect(page).to have_content('SKU')
    expect(page).to have_content('abc123')
    expect(page).to have_content('Quantidade')
    expect(page).to have_content('7')
    expect(page).to have_content('Data de Entrada')
    expect(page).to have_content(ProductEntry.first.created_at.strftime('%d/%m/%Y').to_s)
    expect(page).to have_content('abc124')
    expect(page).to have_content('3')
    expect(page).to have_content(ProductEntry.last.created_at.strftime('%d/%m/%Y').to_s)
    expect(page).to have_content('CSV importado com sucesso')
    expect(Item.count).to eq(10)
    expect(ProductEntry.count).to eq(2)
  end
  it 'all attributes must be filled' do
    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    attach_file 'Arquivo CSV', Rails.root.join('spec/fixture/missing_attribute_entry.csv')
    click_on 'Enviar arquivo'

    expect(page).to have_content('Nenhum atributo pode estar faltando')
    expect(current_path).to eq new_product_entry_path
    expect(ProductEntry.count).to be_zero
    expect(Item.count).to be_zero
  end

  it 'must be an .csv' do
    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    attach_file 'Arquivo CSV', Rails.root.join('spec/fixture/not_csv.txt')
    click_on 'Enviar arquivo'

    expect(page).to have_content('O arquivo precisa ser válido')
    expect(current_path).to eq new_product_entry_path
  end

  it 'must send a file' do
    login_as_user
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Entrada'
    click_on 'Enviar arquivo'

    expect(page).to have_content('Um arquivo deve ser enviado!')
    expect(current_path).to eq new_product_entry_path
  end
end
