require 'rails_helper'

describe 'Reserve API' do
  context 'post /api/v1/reserve' do
    it 'should create reserve for a product' do
      product = create(:product, sku: 'AIXRP128')
      supplier = create(:supplier)
      create(:warehouse, name: 'Galpão 1')
      item = create(:item, code: 'code000001', invoice: 'nf0001', supplier: supplier, product: product)
      post '/api/v1/reserve', params: {
        reserve: {
          sku: product.sku,
          transportadora: 'Transportadora 1',
          request_number: 125,
          warehouse: 'Galpão 1'
        }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include(item.code)
      expect(response.body).to include(product.sku)
      expect(response.body).to include('reserved')
    end
  end
end
