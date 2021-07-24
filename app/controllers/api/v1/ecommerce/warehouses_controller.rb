class Api::V1::Ecommerce::WarehousesController < ActionController::API
  def list
    @warehouses = Item.where(sku: params[:sku]).group(:warehouse).count.sort.reverse
    raise ActiveRecord::RecordNotFound if @warehouses.blank?

    render json: { warehouses: @warehouses.map { |n| n[0].to_ecommerce_json(n[1]) } }
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
