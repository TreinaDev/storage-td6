require 'rails_helper'

describe 'Freightage Products API' do
  context 'GET /api/v1/freightage/warehouses/:sku' do
    let(:address1) { build(:address, latitude: '-23.5672582', longitude: '-46.651529') }
    let(:address2) { build(:address, latitude: '-23.5672582', longitude: '-46.651529') }
    let(:address3) { build(:address, latitude: '-23.5672582', longitude: '-46.651529') }
    let(:warehouse1) { create(:warehouse, code: 'ABCD') }
    let(:warehouse2) { create(:warehouse, code: 'DEFG') }
    let(:warehouse3) { create(:warehouse, code: 'HIJK') }
    let(:product) { create(:product, sku: 'abc123') }

    it 'should return a warehouse' do
      warehouse1.addresses << address1
      warehouse2.addresses << address2
      warehouse3.addresses << address3

      ProductWarehouse.create!(warehouse: warehouse1, product: product)
      ProductWarehouse.create!(warehouse: warehouse2, product: product)
      ProductWarehouse.create!(warehouse: warehouse3, product: product)

      get '/api/v1/freightage/warehouses/abc123'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Warehouse.count)
      expect(parsed_body[0]['warehouse_code']).to include('ABCD')
      expect(parsed_body[1]['warehouse_code']).to include('DEFG')
      expect(parsed_body[2]['warehouse_code']).to include('HIJK')
      expect(parsed_body[0]['lat']).to include('-23.5672582')
      expect(parsed_body[0]['lon']).to include('-46.651529')
    end

    it 'should not found a warehouse by sku' do
      get '/api/v1/freightage/warehouses/naoexi'

      expect(response).to have_http_status(404)
    end
  end
end
