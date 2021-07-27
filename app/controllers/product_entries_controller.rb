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
    if ProductEntry.import_from_csv(params, current_user.warehouse)
      redirect_to product_entries_path, notice: t('.success')
    else
      redirect_to new_product_entry_path, notice: t('.fail')
    end
  rescue MustBeAValidCsv
    redirect_to new_product_entry_path, notice: t('.csv_must_be_valid')
  rescue FileMustBeUploaded
    redirect_to new_product_entry_path, notice: t('.file_must_be_uploaded')
  end

  private

  def entry_params
    params.require(:product_entry).permit(:sku, :invoice, :quantity, :supplier_id)
  end
end
