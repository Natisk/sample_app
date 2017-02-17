require 'spec_helper'

describe PersonalMessage, type: :model do

  context do
    subject { PersonalMessage.new }

    it { should validate_presence_of(:body) }

    it { should belong_to(:user) }
    it { should belong_to(:conversation) }

    it { should have_db_column(:body).of_type(:text)}
    it { should have_db_column(:conversation_id).of_type(:integer)}
    it { should have_db_column(:user_id).of_type(:integer)}
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false)}
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)}
  end
end