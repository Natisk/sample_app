require 'spec_helper'

describe Micropost, type: :model do

  it 'is valid with valid attributes' do
    user = User.new(id: 1, name: 'test', email: 'test@example.com', password: 'qwerty')
    expect(Micropost.new(user: user, content: 'test', created_at: Time.zone.now, updated_at:  Time.zone.now)).to be_valid
  end

  context do
    subject { Micropost.new }

    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:content) }

    it { should belong_to(:user) }
    it { should have_many(:comments) }

    it { should have_db_column(:content).of_type(:text)}
    it { should have_db_column(:user_id).of_type(:integer)}
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false)}
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)}
    it { should have_db_column(:picture).of_type(:string)}
  end
end