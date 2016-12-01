FactoryGirl.define do
  factory :user do
    name 'user'
    email 'test@example.com'
    password 'qwerty'
    role 'member'
  end
end