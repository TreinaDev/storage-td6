require 'rails_helper'

describe 'Admin creates user' do
  it 'successfully' do
    warehouse = create(:warehouse, name: 'Galpão Santa Maria')
    admin = create(:user, role: 'admin')
    login_as admin

    visit users_path
    click_on 'Criar novo usuário'

    fill_in 'Nome', with: 'Fulano'
    fill_in 'Email', with: 'fulano@mercadores.com.br'
    fill_in 'CPF', with: CPF.generate
    fill_in 'Matrícula', with: '012345'
    select 'Galpão Santa Maria', from: 'Galpão de origem'

    expect { click_on 'Criar Usuário' }.to change { User.count }.by(1)
    expect(page).to have_text('Usuário criado com sucesso')
    expect(current_path).to eq(users_path)
  end

  it 'and must have valid params' do
    warehouse = create(:warehouse, name: 'Galpão Santa Maria')
    admin = create(:user, role: 'admin')
    login_as admin
    
    visit users_path
    click_on 'Criar novo usuário'

    expect { click_on 'Criar Usuário' }.to_not change { User.count }
    expect(page).to have_text('não pode ficar em branco', count: 5)
    expect(page).to have_text('domínio não permitido')
    # TODO: Investigar isso
    # expect(current_path).to eq(new_user_path)
  end

  it 'cannot create if role equal user' do
    user_not_admin = build(:user)
    login_as user_not_admin, scope: :user
    visit new_user_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_text('Você não tem permissão para acessar essa área')
  end
end