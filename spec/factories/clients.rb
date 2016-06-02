FactoryGirl.define do
  factory :client do
    address "Rua Teste 356, Vila João (entre rua 3 e 4)"
    name "Client"
    phone "(19) 999999999"
    status :active
    user
  end
end
