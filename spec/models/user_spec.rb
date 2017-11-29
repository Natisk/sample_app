# frozen_string_literal: true

require 'spec_helper'

describe User, type: :model do

  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:micropost1) { FactoryBot.create(:micropost, user: user1) }
  let(:micropost2) { FactoryBot.create(:micropost, user: user2) }
  before { @test_relationships = user1.follow(user2) }

  it 'is valid with valid attributes' do
    expect(user1).to be_valid
  end

  it 'is invalid with blank attributes' do
    expect(User.create( name: '', email: '', password: '', id: '' )).not_to be_valid
  end

  it 'is possible to follow other user' do
    expect(user1.following).to include(user2)
    expect(user1.followers).not_to include(user2)

    expect(user2.followers).to include(user1)
    expect(user2.following).not_to include(user1)
  end

  it 'is possible to find active relationships' do
    expect(user1.following?(user2)).to eq(true)
  end

  it 'show users feed' do
    expect(user1.feed).to include(micropost1, micropost2)
  end

  it 'is possible to unfollow other user' do
    user1.unfollow(user2)
    expect(user1.following?(user2)).to eq(false)
  end

  context 'model connection' do
    it { should have_many(:microposts) }
    it { should have_many(:active_relationships).class_name('Relationship') }
    it { should have_many(:passive_relationships).class_name('Relationship') }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { should have_many(:comments) }
    it { should have_many(:chat_rooms) }
    it { should have_many(:messages) }
    it { should have_many(:authored_conversations).class_name('Conversation') }
    it { should have_many(:received_conversations).class_name('Conversation') }
    it { should have_many(:personal_messages) }
  end

  context 'User db column' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { should have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:role).of_type(:string).with_options(default: 'member') }
  end
end
