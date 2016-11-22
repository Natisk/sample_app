class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :commenter, class_name: 'User'

  delegate :name, to: :commenter, prefix: true

  validates :commenter, presence: true
  validates :body, presence: true, length: { maximum: 140 }
end
