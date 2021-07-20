module LoginMacros
  def login_as_admin(admin = create(:user, role: :admin))
    login_as admin
  end

  def login_as_user
    warehouse = create(:warehouse)
    user = create(:user, warehouse: warehouse)

    login_as user
  end
end
