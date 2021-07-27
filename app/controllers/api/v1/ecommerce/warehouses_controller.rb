class Api::V1::Ecommerce::WarehousesController < ActionController::API
  def list
    @warehouses = Item.availables.where(sku: params[:sku]).group(:warehouse).order(sort: :desc).count
    raise ActiveRecord::RecordNotFound if @warehouses.blank?

    render json: { warehouses: @warehouses.map { |n| n[0].to_ecommerce_json(n[1]) } }
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
