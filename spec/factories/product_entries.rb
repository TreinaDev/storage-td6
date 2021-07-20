FactoryBot.define do
  factory :product_entry do
    sku { 'MyString' }
    invoice { 'MyString' }
    quantity { 1 }
    supplier
    warehouse
  end
end
