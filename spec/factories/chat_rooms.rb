# frozen_string_literal: true
# == Schema Information
#
# Table name: chat_rooms
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


FactoryBot.define do
  factory :chat_room do
    title 'MyString'
    user nil
  end
end
