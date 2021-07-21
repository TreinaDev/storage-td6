require 'rails_helper'

describe 'Account Managment' do
    context 'Login' do
        it 'as Admin' do
            visit root_path
            create(:user, role: :admin, email: 'admin@mercadores.com.br', name: 'Admin', cpf: '71187882011')
            click_on 'Login'

            fill_in 'Email', with: 'admin@mercadores.com.br'
            fill_in 'Senha', with: '71187882011'
            #TODO:colocar i18n
            click_on 'Log in'

            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content('Admin')
            expect(current_path).to eq(root_path)
            expect(page).to_not have_link('Login')
            expect(page).to have_link('Sair')
        end
    end
end
