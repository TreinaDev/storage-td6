require 'rails_helper'

describe 'Ecommerce Warehouses API' do
  context 'GET /api/v1/ecommerce/warehouses/:code' do
    it 'should return a warehouse address' do
      FactoryBot.build_list(:address, 3) do |address, index|
        warehouse = create(:warehouse, code: "000#{index}")
        warehouse.address = address
      end

      get '/api/v1/ecommerce/warehouse/0001'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['warehouse']['code']).to eq('0001')
      expect(parsed_body['warehouse']['full_address'].to_json).to eq(
        Warehouse.first.address.to_json
      )
    end

    it 'should not found a warehouse by sku' do
      get '/api/v1/ecommerce/warehouse/0001'

      expect(response).to have_http_status(404)
    end
  end
end
