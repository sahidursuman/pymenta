# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document_line do
    id "MyString"
    version "MyString"
    domain "MyString"
    username "MyString"
    code "MyString"
    document_number "MyString"
    type ""
    description "MyString"
    date "2014-10-31"
    in_quantity "9.99"
    out_quantity "9.99"
    price "9.99"
    total "9.99"
    year 1
    month 1
  end
end
