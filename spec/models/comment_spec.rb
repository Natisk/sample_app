# frozen_string_literal: true

require 'spec_helper'

describe Comment, type: :model do

  context do
    subject { Comment.new }

    it { should validate_presence_of(:commenter) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(140).on(:create) }

    it { should belong_to(:micropost) }
    it { should belong_to(:commenter) }

    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:micropost_id).of_type(:integer) }
    it { should have_db_column(:commenter_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end
