# frozen_string_literal: true
# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  author_id   :integer
#  receiver_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


FactoryBot.define do
  factory :conversation do
    author_id 1
    receiver_id 1
  end
end
