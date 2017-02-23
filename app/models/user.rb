class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2, :vk]

  has_many :oauths, dependent: :destroy, autosave: true, inverse_of: :user
  accepts_nested_attributes_for :oauths

  has_many :microposts, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: :commenter_id, dependent: :destroy

  has_many :active_relationships, class_name:  'Relationship',
           foreign_key: :follower_id,
           dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
           foreign_key: :followed_id,
           dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'
  has_many :personal_messages, dependent: :destroy

  ROLES = %w(admin moderator member)

  def feed
    ids = following.pluck(:id)
    ids.push(id)
    Micropost.where(user_id: ids.compact.uniq)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.find_user_by_oauth(uid: nil, provider: nil)
    return nil unless uid || provider
    Oauth.find_by(uid: uid, provider: provider)&.user
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end
end
