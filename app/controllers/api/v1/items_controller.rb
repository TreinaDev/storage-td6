class Api::V1::ItemsController < Api::V1::ApiController
  def reserve
    if reserve_params
      @product = Product.find_by!(sku: params[:reserve][:sku])
      @warehouse = Warehouse.find_by!(name: params[:reserve][:warehouse])
    end
    @item = Item.find_by!(product: @product)
    @params = reserve_params.except(:warehouse)
    @item.save_log(@params)
    render json: @item.as_json(include: { product: { only: :sku } }, except: :product_id), status:
    :created
  end

  private

  def reserve_params
    params.require(:reserve).permit(:sku, :warehouse, :request_number, :shipping_company)
  end
end
