FactoryGirl.define do
  factory :menu do
    menu_name { Faker::Date.forward(20) }
    user
  end
end
