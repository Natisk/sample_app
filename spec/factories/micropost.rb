FactoryGirl.define do

  factory :micropost do
    user
    content Faker::Lorem.sentence
  end
end