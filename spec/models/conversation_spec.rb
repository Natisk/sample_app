require 'spec_helper'

describe Conversation, type: :model do

  context do
    subject { Conversation.new }

    it { should belong_to(:author) }
    it { should belong_to(:receiver) }
    it { should have_many(:personal_messages).order(created_at: :asc) }

    it { should have_db_column(:author_id).of_type(:integer)}
    it { should have_db_column(:receiver_id).of_type(:integer)}
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false)}
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)}
  end
end
