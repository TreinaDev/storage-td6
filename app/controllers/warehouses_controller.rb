class WarehousesController < AuthenticationController
  before_action :authorize_admin!, only: %i[index new create]

  def index
    @warehouse = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.address = Address.new(address_params)
    if @warehouse.save
      redirect_to warehouse_path(@warehouse), notice: t('.success')
    else
      render :new
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code)
  end

  def address_params
    params.require(:address).permit(:name, :number, :district, :city, :state, :zip_code)
  end
end
