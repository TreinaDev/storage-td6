FactoryBot.define do
  factory :product do
    sequence(:sku) { |n| n }
  end
end
