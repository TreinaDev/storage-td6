FactoryBot.define do
  factory :address do
    name { 'MyString' }
    number { 1 }
    district { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    zip_code { '12345678' }
    addressable { nil }
  end
end
