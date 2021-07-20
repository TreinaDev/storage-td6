FactoryBot.define do
  factory :product_entry do
    sku { 'abc123' }
    invoice { '123654' }
    quantity { 2 }
    supplier
    warehouse
  end
end
