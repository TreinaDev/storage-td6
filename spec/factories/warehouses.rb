FactoryBot.define do
  factory :warehouse do
<<<<<<< HEAD
    code { 'MyString' }
    name { 'MyString' }
=======
    code { 'code' }
    sequence(:name) { |n| "Galpão #{n}" }
>>>>>>> d98ac638e0ff45ada630a17a20288b24fbbe0a28
  end
end
