require 'spec_helper'

describe 'the signin process', :js do

  context 'sign in' do
    before { user_login }

    scenario 'signs me in' do
      expect(page).to have_content 'Signed in successfully.'
    end
  end

  context 'sign out' do
    before { user_logout }

    scenario 'signs me out' do
      expect(page).to have_content 'Signed out successfully.'
    end
  end
end