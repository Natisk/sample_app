# frozen_string_literal: true

require 'spec_helper'

describe 'user', :js do
  context 'edit user info by user' do
    before { user_login }

    scenario 'edit user info' do
      sleep(1)
      find('#dropdown').click
      # click_link 'dropdown'
      click_link 'Settings'
      within('.form-horizontal') do
        fill_in 'Name', with: 'Test Username'
        fill_in 'Email', with: 'testemail@example.com'
        fill_in 'Current password', with: 'qwerty'
      end
      click_button 'Save changes'
      sleep(1)
      expect(page).to have_content 'You updated your account successfully'
    end
  end

  context 'edit user info and delete user by admin' do
    before { admin_login }
    let(:user) { FactoryBot.create(:user) }

    scenario 'edit user info' do
      sleep(1)
      visit "/users/#{user.id}/edit"
      within('.form-horizontal') do
        fill_in 'Name', with: 'Test Username'
        fill_in 'Email', with: 'testemail@example.com'
      end
      click_button 'Save changes'
      expect(page).to have_content 'Profile updated'
    end

    scenario 'delete user' do
      sleep(1)
      visit "/users/#{user.id}/edit"
      find('.btn-danger').click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'User deleted'
    end
  end
end
