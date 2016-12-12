class Oauth < ApplicationRecord
  belongs_to :user, inverse_of: :oauths
  # validates :uid, :provider, :user, presence: true
  validates :uid, uniqueness: { scope: :provider }
end
