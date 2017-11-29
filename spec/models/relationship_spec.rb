# frozen_string_literal: true

require 'spec_helper'

describe Relationship, type: :model do

  context do
    subject { Relationship.new }

    it { should validate_presence_of(:follower_id) }
    it { should validate_presence_of(:followed_id) }

    it { should belong_to(:follower) }
    it { should belong_to(:followed) }

    it { should have_db_column(:follower_id).of_type(:integer) }
    it { should have_db_column(:followed_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end
