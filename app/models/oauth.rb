class Oauth < ApplicationRecord
  belongs_to :user, inverse_of: :oauths
  validates :user, :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates :provider, inclusion: { in: PROVIDERS }
end
