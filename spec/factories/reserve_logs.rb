FactoryBot.define do
  factory :reserve_log do
    item
    shipping_company { 'MyString' }
    request_number { 1 }
  end
end
