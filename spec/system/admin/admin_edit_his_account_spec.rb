require 'rails_helper'

describe 'Admin edit his account' do
  it 'successfully' do
    login_as_admin

    visit root_path
    click_on 'Editar Perfil'

    fill_in 'Nome', with: 'Editado'
    fill_in 'Senha', with: '10101010'
    fill_in 'Confirmação de Senha', with: '10101010'
    click_on 'Atualizar Usuário'

    expect(page).to have_text('Usuário atualizado com sucesso')
    expect(page).to have_text('Editado')
  end

  it 'and fields must be valid' do
    login_as_admin

    visit root_path
    click_on 'Editar Perfil'

    fill_in 'Nome', with: ''
    fill_in 'Senha', with: '1010'
    fill_in 'Confirmação de Senha', with: '1010'
    click_on 'Atualizar Usuário'

    expect(page).to have_text('Não foi possível atualizar o usuário')
    expect(page).to have_text('não pode ficar em branco')
    expect(page).to have_text('Senha é muito curto')
    expect(page).to have_text('Editar Perfil')
  end

  it 'cannot change user without login' do
    user = create(:user, role: :admin)
    visit edit_user_path(user)

    expect(page).to have_text('Para continuar, efetue login ou registre-se.')
    expect(current_path).to eq(new_user_session_path)
  end
end
