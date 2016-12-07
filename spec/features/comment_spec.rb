require 'spec_helper'

describe 'comment', :js do

  context 'create comment' do
    before { user_login }
    let!(:micropost) { FactoryGirl.create(:micropost, user: @user) }

    scenario 'add comment to micropost' do
      fill_in ('comment[body]'), with: 'test comment'
      click_button 'Post comment'
      sleep(1)
      within all('.user-comment').last do
        expect(page).to have_content @user.name
        expect(page).to have_content 'test comment'
      end
    end
  end

  context 'show/hide buttons' do
    before :each do
      user_login
      let(:micropost) {FactoryGirl.create(:micropost, user: @user)}
      FactoryGirl.create(:comment, commenter: @user, micropost_id: micropost.id, body: 'test comment')
      5.times { FactoryGirl.create(:comment, commenter: @user, micropost_id: micropost.id) }
    end

    scenario 'add comment to micropost' do
      visit abyss_path
      sleep(1)
      find('.see-more').click
      expect(page).to have_content 'test comment'
      sleep(1)
      find('.hide-comments').click
      expect(page).not_to have_content 'test comment'
    end
  end

  context 'delete comment by admin' do
    before { admin_login }
    let(:micropost) {FactoryGirl.create(:micropost, user: @admin)}
    let(:user) { FactoryGirl.create(:user) }
    let!(:comment) { FactoryGirl.create(:comment, commenter: user, micropost_id: @micropost.id) }

    scenario 'delete comment' do
      visit root_path
      sleep(1)
      within all('.user-comment').last do
        find('.delete-comment').click
      end
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      expect(page).not_to have_content comment
    end
  end

  context 'delete comment by moderator' do
    before { moderator_login }
    let(:user) { FactoryGirl.create(:user) }
    let(:micropost) {FactoryGirl.create(:micropost, user: @moderator)}
    let!(:comment) { FactoryGirl.create(:comment, commenter: user, micropost_id: @micropost.id) }

    scenario 'delete comment' do
      visit root_path
      sleep(1)
      within all('.user-comment').last do
        find('.delete-comment').click
      end
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      expect(page).not_to have_content comment
    end
  end
end

