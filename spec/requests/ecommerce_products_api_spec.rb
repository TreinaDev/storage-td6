require 'rails_helper'

describe 'Ecommerce Products API' do
  context 'GET /api/v1/ecommerce/warehouses/:sku' do
    let(:product) { create(:product, sku: 'abc123') }

    it 'should return all warehouse with quantity of product requested' do
      warehouse01 = create(:warehouse, code: 'AMZ1')
      warehouse02 = create(:warehouse, code: 'ROB2')
      warehouse03 = create(:warehouse, code: 'ZER3')
      create(:product_warehouse, warehouse: warehouse01, product: product)
      create(:product_warehouse, warehouse: warehouse02, product: product)
      create(:product_warehouse, warehouse: warehouse03, product: product)
      supplier = create(:supplier)
      create(:product_entry, sku: product.sku, quantity: 5, supplier: supplier, warehouse: warehouse01)
      create(:product_entry, sku: product.sku, quantity: 10, supplier: supplier, warehouse: warehouse02)

      get '/api/v1/ecommerce/warehouses/abc123'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['warehouses'].count).to eq(ProductEntry.count)
      expect(parsed_body['warehouses'][0]['warehouse_code']).to eq('ROB2')
      expect(parsed_body['warehouses'][0]['quantity']).to eq(10)
      expect(parsed_body['warehouses'][1]['warehouse_code']).to eq('AMZ1')
      expect(parsed_body['warehouses'][1]['quantity']).to eq(5)
    end

    it 'should not found a warehouse by sku' do
      get '/api/v1/ecommerce/warehouses/naoexi'

      expect(response).to have_http_status(404)
    end

    it 'should only show available items' do
      warehouse01 = create(:warehouse, code: 'AMZ1')
      warehouse02 = create(:warehouse, code: 'ROB2')
      warehouse03 = create(:warehouse, code: 'ZER3')
      create(:product_warehouse, warehouse: warehouse01, product: product)
      create(:product_warehouse, warehouse: warehouse02, product: product)
      create(:product_warehouse, warehouse: warehouse03, product: product)
      supplier = create(:supplier)
      create(:product_entry, sku: product.sku, quantity: 5, supplier: supplier, warehouse: warehouse01)
      create(:product_entry, sku: product.sku, quantity: 10, supplier: supplier, warehouse: warehouse02)
      Item.first.reserved!
      Item.second.reserved!
      Item.last.dispatched!

      get '/api/v1/ecommerce/warehouses/abc123'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['warehouses'].count).to eq(ProductEntry.count)
      expect(parsed_body['warehouses'][0]['warehouse_code']).to eq('ROB2')
      expect(parsed_body['warehouses'][0]['quantity']).to eq(9)
      expect(parsed_body['warehouses'][1]['warehouse_code']).to eq('AMZ1')
      expect(parsed_body['warehouses'][1]['quantity']).to eq(3)
    end
  end
end
