# frozen_string_literal: true

FactoryBot.define do
  factory :personal_message do
    body 'MyText'
    conversation nil
    user nil
  end
end
