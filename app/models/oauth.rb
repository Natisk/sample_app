# frozen_string_literal: true

# == Schema Information
#
# Table name: oauths
#
#  id         :integer          not null, primary key
#  uid        :string
#  provider   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  link       :string
#

class Oauth < ApplicationRecord
  belongs_to :user, inverse_of: :oauths

  validates :user, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates :provider, inclusion: { in: PROVIDERS }
end
