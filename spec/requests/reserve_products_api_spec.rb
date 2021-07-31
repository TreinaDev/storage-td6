require 'rails_helper'

describe 'Reserve API' do
  context 'post /api/v1/reserve' do
    it 'should create reserve for a product' do
      supplier = create(:supplier)
      warehouse = create(:warehouse, code: 'abcd', name: 'Galpão 1')
      create(:product_entry, sku: 'AIXRP128', quantity: 1, warehouse: warehouse, supplier: supplier)
      post '/api/v1/reserve', params: {
        reserve: {
          sku: Item.last.sku,
          shipping_company: 'XYZ8',
          request_number: 125,
          warehouse: 'abcd'
        }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('abcd000001')
      expect(response.body).to include('AIXRP128')
      expect(response.body).to include('reserved')
    end

    it 'should not found product unregistered' do
      post '/api/v1/reserve', params: {
        reserve: {
          sku: 'AIXRP128',
          shipping_company: 'XYZ8',
          request_number: 125,
          warehouse: 'abcd'
        }
      }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Produto não encontrado')
    end

    it 'should not found unregistered warehouse' do
      supplier = create(:supplier)
      warehouse = create(:warehouse, code: 'abce', name: 'Galpão 2')
      create(:product_entry, sku: 'AIXRP128', quantity: 1, warehouse: warehouse, supplier: supplier)

      post '/api/v1/reserve', params: {
        reserve: {
          sku: 'AIXRP128',
          shipping_company: 'XYZ8',
          request_number: 125,
          warehouse: 'abcd'
        }
      }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Galpão não encontrado')
    end

    it 'should not accept without valid params' do
      post '/api/v1/reserve', params: {
        reserve: {
        }
      }

      expect(response).to have_http_status(412)
      expect(response.body).to include(
        'parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente'
      )
    end
  end
end
