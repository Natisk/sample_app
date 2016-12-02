FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :confirmed_at do
    Time.now
  end

  factory :user, aliases: [:commenter] do
    name 'test user'
    email
    password 'qwerty'
    confirmed_at
    role 'member'

    factory :admin do
      role 'admin'
    end

    factory :moderator do
      role 'moderator'
    end
  end

   factory :micropost do
     user
     content 'Test micropost'
   end

   # factory :comment do
   #   body 'Test comment'
   # end
end