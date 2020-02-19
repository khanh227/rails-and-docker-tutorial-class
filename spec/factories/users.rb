FactoryGirl.define do 
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "@ssword-#{SecureRandom.hex(8)}"
    role_user :customer

    factory :admin_user do
      role_user :admin
    end

    factory :restaurant_user do
      role_user :restaurant
    end

  end
end
