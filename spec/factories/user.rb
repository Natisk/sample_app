FactoryGirl.define do
  factory :user do
    name 'user'
    email 'test@example.com'
    password 'qwerty'
    role 'member'
  end

  factory :admin do
    name 'admin'
    email 'admin@admin.com'
    password 'admin_'
    role 'admin'
  end
end