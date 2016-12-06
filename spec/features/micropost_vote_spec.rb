require 'spec_helper'

describe 'micropost', :js do

  context 'vote micropost' do
    before { user_login }
    let!(:micropost) { FactoryGirl.create(:micropost, user: @user) }

    scenario 'like micropost' do
      visit root_path
      find('.like').click
      # click_link 'Like')
      within ('.like') do
        expect(page).to have_content '1'
      end
      within ('.dislike') do
        expect(page).not_to have_content '1'
      end
    end

    scenario 'dislike micropost' do
      click_link 'Dislike'
      within ('.dislike') do
        expect(page).to have_content '1'
      end
      within ('.like') do
        expect(page).not_to have_content '1'
      end
    end
  end
end

