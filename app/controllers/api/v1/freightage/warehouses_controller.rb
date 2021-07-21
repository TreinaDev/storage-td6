class Api::V1::Freightage::WarehousesController < ActionController::API
  def list
    @warehouses = Product.find_by!(sku: params[:sku]).warehouses
    render json: { warehouses: @warehouses }
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end