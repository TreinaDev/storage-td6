class UsersController < AuthenticationController
  before_action :authorize_admin!, only: %i[new create]
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @warehouses = Warehouse.all
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to users_path, notice: t('.success')
    else
      @warehouses = Warehouse.all
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_edit_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :cpf, :registration_code, :warehouse_id
  end

  def user_edit_params
    params.require(:user).permit :name, :password, :password_confirmation
  end

  def set_user
    @user = current_user
  end
end
