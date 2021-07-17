FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "aeio00000#{n}" }
    invoice { 'MyString' }
    supplier
    product
  end
end
