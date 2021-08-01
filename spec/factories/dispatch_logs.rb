FactoryBot.define do
  factory :dispatch_log do
    item
    user { create(:user, warehouse: create(:warehouse)) }
    authorized_person { 'MyString' }
  end
end
