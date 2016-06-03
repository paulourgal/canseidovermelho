FactoryGirl.define do
  factory :sale do
    client
    date Date.today
    user
  end
end
