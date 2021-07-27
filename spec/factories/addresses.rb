FactoryBot.define do
  factory :address do
    name { 'Rua Jaguar' }
    number { 4 }
    district { 'Leão' }
    city { 'Papagolândia' }
    state { 'AM' }
    zip_code { '12345678' }
    addressable { nil }
  end
end
