FactoryGirl.define do
  factory :category do
    name { "#{Faker::Lorem.word} #{SecureRandom.hex}" }
  end
end
