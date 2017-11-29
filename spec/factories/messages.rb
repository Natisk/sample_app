# frozen_string_literal: true
# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  user_id      :integer
#  chat_room_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


FactoryBot.define do
  factory :message do
    body 'MyText'
    user nil
    chat_room nil
  end
end
