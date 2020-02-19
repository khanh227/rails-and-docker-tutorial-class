FactoryGirl.define do
  factory :product do 
    name { "#{Faker::Lorem.word} #{SecureRandom.hex}" }
    description { "Description #{SecureRandom.hex}" }
    price { rand(10000..90000) }
    quatity { rand(1..99) }
    category
    user
  end
end
