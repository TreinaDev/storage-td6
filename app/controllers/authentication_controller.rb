class AuthenticationController < ApplicationController
  before_action :authenticate_user!
  before_action :after_sign_in_path_for

  private

  def authorize_admin!
    redirect_to root_path, alert: t('.not_allowed') unless current_user.admin?
  end

  def after_sign_in_path_for
    if current_user
      redirect_to edit_user_path(current_user) if current_user.created_at == current_user.updated_at && current_user.user?
    end
  end
end
