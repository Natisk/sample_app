class Oauth < ApplicationRecord
  belongs_to :user, inverse_of: :oauths
  validates :user, presence: true
  validates :uid, uniqueness: { scope: :provider }, presence: true
  validates :provider, presence: true, inclusion: { in: PROVIDERS }
end
