class AuthenticationController < ApplicationController
  before_action :authenticate_user!

  private

  def authorize_admin!
    redirect_to root_path, alert: t('errors.messages.not_allowed') unless current_user.admin?
  end
end
