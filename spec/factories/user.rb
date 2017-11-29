# frozen_string_literal: true

FactoryBot.define do

  factory :user, aliases: [:commenter] do
    name {Faker::Name.name}
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'qwerty'
    confirmed_at Time.now
    role 'member'

    factory :admin do
      email 'admin@example.com'
      role 'admin'
    end

    factory :moderator do
      email 'moder@example.com'
      role 'moderator'
    end
  end
end
