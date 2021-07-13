FactoryBot.define do
  factory :item do
    code { "MyString" }
    invoice { "MyString" }
    supplier { nil }
    product { nil }
  end
end
