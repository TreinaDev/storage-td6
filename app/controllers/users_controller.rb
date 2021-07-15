class UsersController < AuthenticationController
  before_action :user_admin, only: %i[new create]

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

  private
  def user_params
    params.require(:user).permit :name, :email, :cpf, :registration_code, :warehouse_id
  end
end