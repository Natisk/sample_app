# frozen_string_literal: true
# == Schema Information
#
# Table name: personal_messages
#
#  id              :integer          not null, primary key
#  body            :text
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


FactoryBot.define do
  factory :personal_message do
    body 'MyText'
    conversation nil
    user nil
  end
end
