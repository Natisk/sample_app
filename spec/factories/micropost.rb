# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    user
    content Faker::Lorem.sentence
  end
end
