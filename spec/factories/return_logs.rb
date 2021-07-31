FactoryBot.define do
  factory :return_log do
    return_entry { nil }
    date { Time.zone.today }
    justification { 'MyText' }
    decision { 1 }
  end
end
