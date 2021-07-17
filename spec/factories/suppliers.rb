FactoryBot.define do
  factory :supplier do
    cnpj { CNPJ.generate(true) }
    name { 'Codeplay SA' }
    trade_name { 'CodePlay' }
  end
end
