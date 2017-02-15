class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :commenter, class_name: 'User'

  delegate :name, to: :commenter, prefix: true

  validates :commenter, :body, presence: true
  validates :body, length: { maximum: 140 }
end
