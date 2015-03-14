# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do

    birth_date Date.today
    confirmed false
    sequence(:email) { |n| "test#{n}@example.com" }
    name "Teste"
    password "s3cr37"
    password_confirmation "s3cr37"
    role User::ROLES.index(:admin)

    trait :user do
      role User::ROLES.index(:user)
    end

    trait :confirmed do
      confirmed true
    end

    trait :invalid do
      password nil
    end

  end

end
