ActiveRecord::Base.transaction do
  warehouses = FactoryBot.create_list(:warehouse, 3)
  puts 'Warehouses created'

  FactoryBot.create(:user, email: 'admin@mercadores.com.br',
                    registration_code: '000000', cpf: '15631606178', role: 'admin')
  FactoryBot.create(:user, email: 'user@mercadores.com.br',
                    registration_code: '000001', cpf: '97478520200', warehouse: warehouses[0])
  FactoryBot.create(:user, email: 'usuario2@mercadores.com.br', 
                    registration_code: '000002', cpf: '20256140553', warehouse: warehouses[1])
  FactoryBot.create(:user, email: 'usuario3@mercadores.com.br', 
                    registration_code: '000003', cpf: '64588404032', warehouse: warehouses[2])
  puts 'Users created'

  warehouses.each do |warehouse|
    address = FactoryBot.create(:address, addressable: warehouse)
  end
  puts 'Adresses created'

  suppliers = FactoryBot.create_list(:supplier, 3)
  puts 'Suppliers created'

  sku = ['2i3enjn', 'a1s2d3f4g5h6', 'h6jk8l9z1c3b']
  (0..2).each do |index|
    FactoryBot.create(:product_entry, quantity: 10, supplier: suppliers[index],
                      warehouse: warehouses[index], sku: sku[index])
  end
  ProductEntry.last.items.update_all(status: 10)

  puts 'Products created'
  puts 'Product Entries created'
  puts 'Items created'

  # Item.all.each do |item|
  #   item.reserved! if item.id > 10
  # end
  puts 'Items reserved'


  (1...2).each do |index| 
    FactoryBot.create(:product_warehouse, product: Product.find(index), warehouse: Warehouse.find(index))
  end
  puts 'Product Warehouses created'
end
