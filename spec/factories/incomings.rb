# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incoming do
    kind 1
    day "2015-01-27"
    value ""
    user
  end
end
