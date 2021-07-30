class Api::V1::Freightage::WarehousesController < Api::V1::ApiController
  def list
    @warehouses = Product.find_by!(sku: params[:sku]).warehouses
    render json: { warehouses: @warehouses }
  end
end
