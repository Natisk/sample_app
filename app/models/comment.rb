# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :text
#  micropost_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  commenter_id :integer
#

class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :commenter, class_name: 'User'

  delegate :name, to: :commenter, prefix: true

  validates :commenter, :body, presence: true
  validates :body, length: { maximum: 140 }
end
