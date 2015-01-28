# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do

    name "Teste"
    birth_date Date.today
    sequence(:email) { |n| "test#{n}@example.com" }
    password "s3cr37"
    password_confirmation "s3cr37"

    trait :invalid do
      password nil
    end

  end

end
