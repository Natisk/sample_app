# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    micropost
    commenter
    body Faker::Lorem.sentence
  end
end
