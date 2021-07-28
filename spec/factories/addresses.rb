FactoryBot.define do
  factory :address do
    name { 'Alameda Santos' }
    number { 1293 }
    district { 'Jardim Paulista' }
    city { 'São Paulo' }
    state { 'SP' }
    zip_code { '01419002' }
    addressable { nil }
    latitude { -23.5672582 }
    longitude { -46.651529 }
  end
end
