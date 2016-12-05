require 'spec_helper'

describe 'user' do
  context 'edit user info by user' do
    before { user_login }

    scenario 'edit micropost' do
      # visit_path

    end
  end

  context 'edit user info by admin' do
    before { admin_login }
    let(:user) { FactoryGirl.create(:user) }
  end
end