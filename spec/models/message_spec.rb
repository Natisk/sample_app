require 'spec_helper'

describe Message, type: :model do

  context do
    subject { Message.new }

    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(2).is_at_most(1000).on(:create) }

    it { should belong_to(:user) }
    it { should belong_to(:chat_room) }

    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:chat_room_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end
