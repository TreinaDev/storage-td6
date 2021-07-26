require 'rails_helper'

describe 'User register Product Entr by csv' do
  it 'successfully' do
      create(:supplier)
  
      login_as_user
      visit root_path
      click_on 'Produtos'
      click_on 'Adicionar Entrada'
      attach_file 'Arquivo CSV', Rails.root.join('spec/fixture/entrada.csv')
      click_on 'Enviar arquivo'

      expect(current_path).to eq(product_entries_path)
      #expect(page).to have_content('Entrada de Produtos')
      expect(page).to have_content('SKU: abc123')
      expect(page).to have_content('Quantidade: 7')
      expect(page).to have_content("Data de Entrada: #{ProductEntry.last.created_at.strftime('%d/%m/%Y')}")
      # expect(page).to have_link('Voltar', href: root_path)
  end
end
