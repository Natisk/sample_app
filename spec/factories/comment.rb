FactoryGirl.define do

  factory :comment do
    micropost
    commenter
    body Faker::Lorem.sentence
  end
end