FactoryGirl.define do
  factory :category do
    name "MyCategory"
    kind :incoming
    user
  end
end
