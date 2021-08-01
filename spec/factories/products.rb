FactoryBot.define do
  factory :product do
    sequence(:sku) { |n| n.to_s.rjust(9, '0') }
  end
end
