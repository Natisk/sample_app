FactoryGirl.define do

  factory :user, aliases: [:commenter] do
    name 'test user'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'qwerty'
    confirmed_at Time.now
    role 'member'

    factory :admin do
      role 'admin'
    end

    factory :moderator do
      role 'moderator'
    end
  end
end