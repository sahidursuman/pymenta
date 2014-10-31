# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    id "MyString"
    version "MyString"
    domain "MyString"
    username "MyString"
    payment_type "MyString"
    notes "MyString"
    date "2014-10-31"
    amount "9.99"
  end
end
