class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show change_active]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:notice] = t('.success')
      redirect_to @supplier
    else
      flash[:notice] = t('.fail')
      render :new
    end
  end

  def change_active
    @supplier.switch_allowance
    redirect_to @supplier, notice: t('.success')
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj, :trade_name)
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
end
