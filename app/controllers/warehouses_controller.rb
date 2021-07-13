class WarehousesController < ApplicationController
  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      redirect_to warehouse_path(@warehouse), notice: 'Cadastrado com sucesso'
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

end