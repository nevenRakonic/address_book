FactoryGirl.define do
  factory :contact do
    user
    first_name "John"
    last_name "Doe"
    address "58th street"
    mobile_phone "555-888-999"
    fixed_phone "345-675-545"
  end
end
