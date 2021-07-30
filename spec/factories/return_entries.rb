FactoryBot.define do
  factory :return_entry do
    sequence(:request_number) { |n| n }
    item
  end
end
