FactoryBot.define do
  factory :address do
    name { 'MyString' }
    number { 1 }
    district { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    zip_code { 'MyString' }
    addressable { nil }
  end
end
