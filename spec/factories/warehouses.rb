FactoryBot.define do
  factory :warehouse do
    sequence(:code) { |n| "#{n}#{n}#{n}#{n}" }
    sequence(:name) { |n| "Galpão #{n}" }
  end
end
