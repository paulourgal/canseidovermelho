# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outgoing do
    kind :feeding
    day "2015-01-27"
    value "100"
    user
  end
end
