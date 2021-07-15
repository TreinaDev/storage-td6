class AuthenticationController < ApplicationController
  before_action :authenticate_user!

  def user_admin
    redirect_to new_user_session_path, alert: 'Você não tem permissão para acessar essa área' unless current_user.admin?
  end
end


