require 'rails_helper'

describe 'Freightage Products API' do
  context 'GET /api/v1/freightage/warehouses/:sku' do
    let(:product) { create(:product, sku: 'abc123') }

    it 'should return a warehouse' do
      FactoryBot.build_list(:address, 3) do |address, index|
        warehouse = create(:warehouse, code: "000#{index}")
        warehouse.addresses << address
        create(:product_warehouse, warehouse: warehouse, product: product)
      end

      get '/api/v1/freightage/warehouses/abc123'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['warehouses'].count).to eq(Warehouse.count)
      expect(parsed_body['warehouses'][0]['warehouse_code']).to eq('0000')
      expect(parsed_body['warehouses'][1]['warehouse_code']).to eq('0001')
      expect(parsed_body['warehouses'][2]['warehouse_code']).to eq('0002')
      expect(parsed_body['warehouses'][0]['latitude']).to eq('-23.5672582')
      expect(parsed_body['warehouses'][0]['longitude']).to eq('-46.651529')
      expect(parsed_body['warehouses'][0]['address']).to eq('Alameda Santos')
      expect(parsed_body['warehouses'][0]['number']).to eq(1293)
      expect(parsed_body['warehouses'][0]['district']).to eq('Jardim Paulista')
      expect(parsed_body['warehouses'][0]['city']).to eq('São Paulo')
      expect(parsed_body['warehouses'][0]['state']).to eq('SP')
    end

    it 'should not found a warehouse by sku' do
      get '/api/v1/freightage/warehouses/naoexi'

      expect(response).to have_http_status(404)
    end
  end
end
