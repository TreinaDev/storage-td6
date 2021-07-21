FactoryBot.define do
  factory :product_warehouse do
    warehouse { create(:warehouse) }
    product { create(:product) }
  end
end
