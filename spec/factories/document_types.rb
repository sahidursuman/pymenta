# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document_type do
    id "MyString"
    version "MyString"
    domain "MyString"
    username "MyString"
    description "MyString"
    account_type "MyString"
    stock_type "MyString"
    stock false
  end
end
