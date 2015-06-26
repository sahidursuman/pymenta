# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payments_document do
    id "MyString"
    version "MyString"
    domain "MyString"
    username "MyString"
    type ""
    number "MyString"
    date "2015-02-22"
    total "9.99"
    paid "9.99"
    paid_left "9.99"
    year 1
    month 1
  end
end
