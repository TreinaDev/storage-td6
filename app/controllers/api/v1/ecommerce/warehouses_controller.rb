class Api::V1::Ecommerce::WarehousesController < Api::V1::ApiController
  def list
    @warehouses = Item.availables.where(sku: params[:sku]).group(:warehouse).order(sort: :desc).count
    raise ActiveRecord::RecordNotFound if @warehouses.blank?

    render json: { warehouses: @warehouses.map { |n| n[0].to_ecommerce_json(n[1]) } }
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def address
    @warehouse = Warehouse.find_by!(code: params[:code])
    render json: { warehouse: @warehouse.to_ecommerce_with_address_json }
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
