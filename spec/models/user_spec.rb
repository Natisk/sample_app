require 'spec_helper'

describe User, type: :model do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @micropost1 = create(:micropost, user: @user1)
    @micropost2 = create(:micropost, user: @user2)
    @test_relationships = @user1.follow(@user2)
  end

  it 'is valid with valid attributes' do
    expect(@user1).to be_valid
  end

  it 'is invalid with blank attributes' do
    expect(User.create( name: '', email: '', password: '', id: '' )).not_to be_valid
  end

  it 'is possible to follow other user' do
    expect(@test_relationships.follower_id).to eq(@user1.id)
    expect(@test_relationships.followed_id).to eq(@user2.id)
  end

  it 'is possible to find active relationships' do
    expect(@user1.following?(@user2)).to eq(true)
  end

  it 'show users feed' do
    expect(@user1.feed).to include(@micropost1, @micropost2)
  end

  it 'is possible to unfollow other user' do
    @user1.unfollow(@user2)
    expect(@user1.following?(@user2)).to eq(false)
  end

  context 'model connection' do
    it { should have_many(:microposts) }
    it { should have_many(:active_relationships) }
    it { should have_many(:passive_relationships) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { should have_many(:comments) }

  end

  context 'User db column' do
    it { should have_db_column(:id).of_type(:integer)}
    it { should have_db_column(:name).of_type(:string)}
    it { should have_db_column(:email).of_type(:string).with_options(default: '', null: false)}
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false)}
    it { should have_db_column(:sign_in_count).of_type(:integer).with_options(:default => 0)}
    it { should have_db_column(:role).of_type(:string).with_options(default: 'member')}
  end
end
