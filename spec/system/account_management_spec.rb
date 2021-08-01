require 'rails_helper'
describe 'Account Managment' do
  context 'Login' do
    it 'as Admin' do
      create(:user, role: :admin, email: 'admin@mercadores.com.br', name: 'Admin', cpf: '71187882011')
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'admin@mercadores.com.br'
      fill_in 'Senha', with: '71187882011'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('Admin')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Galpões')
      expect(page).to have_link('Fornecedores')
      expect(page).to have_link('Produtos')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'as User' do
      warehouse = create(:warehouse)
      create(:user, role: :user, email: 'joao@mercadores.com.br', name: 'João',
                    cpf: '71187882011', warehouse: warehouse)

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'joao@mercadores.com.br'
      fill_in 'Senha', with: '71187882011'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('João')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Fornecedores')
      expect(page).to have_link('Produtos')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'as Visiter' do
      visit root_path

      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Criar Galpões')
      expect(page).to_not have_link('Fornecedores')
      expect(page).to_not have_link('Produtos')
    end
  end
  context 'Permission Access' do
    it 'User cannot access Warehouse_paths' do
      login_as_user
      visit warehouses_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Você não tem permissão para acessar essa área')
    end
  end
end
