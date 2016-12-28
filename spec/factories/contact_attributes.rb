FactoryGirl.define do
  factory :contact_attribute do
    sequence(:name)    { |n| "E-mail #{n}" }
    sequence(:content) { |n| "Content #{n}" }
  end
end
