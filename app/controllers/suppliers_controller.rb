class SuppliersController < ApplicationController

  def index
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

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

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj, :trade_name)
  end
end