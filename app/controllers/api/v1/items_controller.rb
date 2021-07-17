class Api::V1::ItemsController < Api::V1::ApiController
  def reserve
    @product = Product.find_by!(sku: params[:reserve][:sku])
    @warehouse = Warehouse.find_by!(name: params[:reserve][:warehouse])
    @item = Item.available_items(@warehouse, @product).first
    @item.reserved!
    # TODO: criar log de entrada na reserva
    render json: @item.as_json(include: { product: { only: :sku } }, except: :product_id), status:
    :created
  end
end
