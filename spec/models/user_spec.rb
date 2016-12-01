require 'spec_helper'

describe User, type: :model do

  pending "add some examples to (or delete) #{__FILE__}"

  context 'model connection' do
    it { should have_many(:articles) }

  end

  context 'User db column' do
    it { should have_db_column(:id).of_type(:integer)}
    it { should have_db_column(:email).of_type(:string).with_options(default: "", null: false)}
    it { should have_db_column(:sign_in_count).of_type(:integer).with_options(:default => 0)}
    it { should have_many(:articles) }
  end
end