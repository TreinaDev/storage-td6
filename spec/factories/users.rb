FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'exemplo@mercadores.com.br' }
    cpf { CPF.generate }
    registration_code { '123456' }
    role { 'user' }
    warehouse { nil }
  end
end
