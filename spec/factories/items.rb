FactoryGirl.define do
  factory :item do
    cost_price 10
    name "Item"
    quantity 5
    status 1
    unitary_price 10
    user
  end
end
