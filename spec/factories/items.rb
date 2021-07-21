FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "abcd#{n.to_s.rjust(6, '0')}" }
    sequence(:sku) { |n| n }
    supplier
    product_entry
    warehouse
  end
end
