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
    @product_entry = current_user.warehouse.product_entries.new(entry_params)
    if @product_entry.save
      redirect_to @product_entry, notice: t('.success')
    else
      flash.now[:notice] = t('.fail')
      render :new
    end
  end

  def create_by_csv
    warehouse = current_user.warehouse
    csv = ProductEntry.convert_csv(params)
    if valid_entries = ProductEntry.create_object_from_csv(csv, warehouse)
      ProductEntry.save_entry(valid_entries)
      redirect_to product_entries_path, notice: 'CSV importado com sucesso'
    end
  end

  private

  def entry_params
    params.require(:product_entry).permit(:sku, :invoice, :quantity, :supplier_id)
  end
end
