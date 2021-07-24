FactoryBot.define do
  factory :warehouse do
    sequence(:code) { |n| n.to_s.rjust(4, '0') }
    sequence(:name) { |n| "Galpão #{n}" }
  end
end
