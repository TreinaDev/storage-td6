class SuppliersController < AuthenticationController
  before_action :set_supplier, only: %i[show change_active edit update]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.address = Address.new(address_params)
    if @supplier.save
      redirect_to @supplier, notice: t('.success')
    else
      flash.now[:notice] = t('.fail')
      render :new
    end
  end

  def change_active
    @supplier.switch_allowance
    redirect_to @supplier, notice: t('.success')
  end

  def edit
    @address = @supplier.address
  end

  def update
    @supplier.update(supplier_params)
    @supplier.address.update(address_params)
    redirect_to @supplier, notice: t('.success')
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj, :trade_name)
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:name, :number, :district, :city, :state, :zip_code)
  end
end
