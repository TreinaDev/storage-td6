require 'rails_helper'

describe 'User view his warehouse' do
  it 'successfully' do
    warehouse = create(:warehouse, code: 'ABC1', name: 'Galpão do Davi')
    user = create(:user, warehouse: warehouse)
    login_as user

    visit root_path
    click_on 'Meu Galpão'

    expect(page).to have_content('Galpão do Davi')
    expect(page).to have_content('ABC1')
  end
end
