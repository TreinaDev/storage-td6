FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "abcd#{n.to_s.rjust(6, '0')}" }
    sequence(:sku) { |n| n.to_s.rjust(9, '0') }
    supplier
    product_entry
    product
    warehouse
  end
end
