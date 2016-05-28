# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incoming do
    category
    day "2015-01-27"
    user
    value "100"
  end
end
