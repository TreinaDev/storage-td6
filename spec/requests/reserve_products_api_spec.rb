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
          shipping_company: 'Transportadora 1',
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

    it 'should not found product unregistered' do
      post '/api/v1/reserve', params: {
        reserve: {
          sku: 'AIXRP128',
          shipping_company: 'Transportadora 1',
          request_number: 125,
          warehouse: 'Galpão 1'
        }
      }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Produto não encontrado')
    end

    it 'should not found unregistered warehouse' do
      product = create(:product, sku: 'AIXRP128')
      supplier = create(:supplier)
      create(:item, code: 'code000001', invoice: 'nf0001', supplier: supplier, product: product)

      post '/api/v1/reserve', params: {
        reserve: {
          sku: 'AIXRP128',
          shipping_company: 'Transportadora 1',
          request_number: 125,
          warehouse: 'Galpão 1'
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
