# frozen_string_literal: true

require 'spec_helper'

describe ChatRoom, type: :model do

  context do
    subject { ChatRoom.new }

    it { should belong_to(:user) }
    it { should have_many(:messages) }

    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end
