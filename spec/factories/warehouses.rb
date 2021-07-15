FactoryBot.define do
  factory :warehouse do
    code { 'code' }
    sequence(:name) { |n| "Galpão #{n}" }
  end
end
