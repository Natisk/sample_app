require 'spec_helper'

describe User, type: :model do

  it 'is valid with valid attributes' do
    expect(User.new(name: 'test', email: 'test@example.com', password: 'qwerty')).to be_valid
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
