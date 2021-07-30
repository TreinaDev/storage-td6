FactoryBot.define do
  factory :return_entry do
    sequence(:request_number) { |n| n }
  end
end
