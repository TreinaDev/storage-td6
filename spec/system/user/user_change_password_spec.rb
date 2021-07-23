require 'rails_helper'

describe 'User change password' do
  context 'on first access' do
    it 'success' do
      warehouse = create(:warehouse)
      create(:user, email: 'jon@mercadores.com.br', cpf: '19875970360', warehouse: warehouse)

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jon@mercadores.com.br'
      fill_in 'Senha', with: '19875970360'
      within 'form' do
        click_on 'Entrar'
      end

      expect(current_path).to eq(edit_password_path)
      expect(page).to have_content('Primeiro acesso, mude sua senha')

      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Alterar Senha'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Senha alterada com sucesso')
    end
  end
end

# "exemplo@mercadores.com.br", role: "user", cpf: "19875970360"