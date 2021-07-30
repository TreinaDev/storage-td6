require 'rails_helper'

describe 'Admin views Warehouses' do
  it 'succesffully' do
    create(:warehouse, name: 'Galpão 1', code: 'abcd')
    create(:warehouse, name: 'Galpão 2', code: 'abce')
    create(:warehouse, name: 'Galpão 3', code: 'abcf')
    admin = create(:user, role: 'admin')
    login_as admin

    visit root_path
    click_on 'Galpões'

    expect(page).to have_content('Galpão 1')
    expect(page).to have_content('abcd')
    expect(page).to have_content('Galpão 2')
    expect(page).to have_content('abce')
    expect(page).to have_content('Galpão 3')
    expect(page).to have_content('abcf')
  end

  it 'shows empty message when there are no warehouses' do
    admin = create(:user, role: 'admin')
    login_as admin

    visit root_path
    click_on 'Galpões'

    expect(page).to have_content('Nenhum Galpão Cadastrado')
  end
end
