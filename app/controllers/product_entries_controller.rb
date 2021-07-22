class ProductEntriesController < AuthenticationController
  def index
    @product_entry = ProductEntry.all
  end

  def show
    @product_entry = ProductEntry.find(params[:id])
  end

  def new
    @product_entry = ProductEntry.new
  end

  def create
    @product_entry = ProductEntry.new(entry_params)
    @product_entry.warehouse = current_user.warehouse
    if @product_entry.save
      redirect_to @product_entry, notice: t('.success')
    else
      flash.now[:notice] = t('.fail')
      render :new
    end
  end

  private

  def entry_params
    params.require(:product_entry).permit(:sku, :invoice, :quantity, :supplier_id, :warehouse_id)
  end
end
