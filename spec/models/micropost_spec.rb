require 'spec_helper'

describe Micropost, type: :model do

  before :each do
    @micropost1 = create(:micropost, user: create(:user))
  end

  it 'is valid with valid attributes' do
    expect(@micropost1).to be_valid
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