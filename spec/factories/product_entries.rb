FactoryBot.define do
  factory :product_entry do
    sequence(:sku) { |n| n }
    invoice { '123654' }
    sequence(:quantity) { |n| n }
    supplier
    warehouse
    product
  end
end
