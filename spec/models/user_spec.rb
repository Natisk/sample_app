require 'spec_helper'

describe User, type: :model do

  # @request.env['devise.mapping'] = Devise.mappings[:user]

  context 'model connection' do
    it { should have_many(:microposts) }

  end

  # context 'User db column' do
  #  it { should have_db_column(:id).of_type(:integer)}
  #  it { should have_db_column(:email).of_type(:string).with_options(default: "", null: false)}
  #  it { should have_db_column(:sign_in_count).of_type(:integer).with_options(:default => 0)}
  #  it { should have_many(:articles) }
  # end
end
