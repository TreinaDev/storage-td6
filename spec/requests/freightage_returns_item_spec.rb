require 'rails_helper'

describe 'Freightage Products API' do
  context 'GET /api/v1/freightage/return_entries' do
    it 'should create a return entry' do
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

    it 'request number must be present' do

      post '/api/v1/freightage/return_entries', params: { return_entry: {} }

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(ReturnEntry.count).to eq(0)
      expect(parsed_body['errors']).to eq('parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente')
    end

    it 'return entry must be present' do

      post '/api/v1/freightage/return_entries', params: { }

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(ReturnEntry.count).to eq(0)
      expect(parsed_body['errors']).to eq('parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente')
    end

    it 'reserve_log request number must exist' do

      post '/api/v1/freightage/return_entries', params: { return_entry: { resquest_number: 123456 } }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(ReturnEntry.count).to eq(0)
      expect(parsed_body['message']).to eq('Log de reserva não encontrado')
    end

    it 'resquest number must be valid' do

      post '/api/v1/freightage/return_entries', params: { return_entry: { resquest_number: 'abccacatua' } }

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(ReturnEntry.count).to eq(0)
      expect(parsed_body['message']).to eq('Log de reserva não encontrado')
    end
  end
end