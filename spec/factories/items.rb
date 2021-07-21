FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "abcd0000#{n}"}
    sequence(:sku) { |n| "#{n}" }
    supplier
    product_entry
    warehouse
  end
end
