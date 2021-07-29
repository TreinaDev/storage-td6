require 'rails_helper'

describe 'Freightage Products API' do
  context 'GET /api/v1/freightage/warehouses/:sku' do
    it 'should return a warehouse' do
      warehouse = FactoryBot.create(:warehouse, code: 'abdc')
      FactoryBot.create(:product_entry, quantity: 1, warehouse: warehouse)
      FactoryBot.create(:reserve_log, request_number: '123456', item: Item.last)

      post '/api/v1/freightage/return_entries', params: { return_entry: { request_number: '123456'} }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(ReturnEntry.count).to eq(1)
      expect(parsed_body['message']).to eq('Ordem de retorno criada com sucesso!')
      expect(parsed_body['return_entry']['id']).to eq(ReturnEntry.last.id)
    end
  end
end