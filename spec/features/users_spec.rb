# frozen_string_literal: true

require 'spec_helper'

describe 'users', :js do

  context 'users role filter on show page' do
    before { user_login }
    let!(:admin) { FactoryBot.create(:admin) }
    let!(:moderator) { FactoryBot.create(:moderator) }

    scenario 'it show only admins when it selected' do
      sleep(1)
      visit '/users'
      check('Admin')
      find('.btn-success').click
      expect(page).to have_content ': admin'
      expect(page).not_to have_content ': member'
      expect(page).not_to have_content ': moderator'
    end

    scenario 'it show only members when it selected' do
      sleep(1)
      visit '/users'
      check('Member')
      find('.btn-success').click
      expect(page).not_to have_content ': admin'
      expect(page).to have_content ': member'
      expect(page).not_to have_content ': moderator'
    end

    scenario 'it show only moderators when it selected' do
      sleep(1)
      visit '/users'
      check('Moderator')
      find('.btn-success').click
      expect(page).not_to have_content ': admin'
      expect(page).not_to have_content ': member'
      expect(page).to have_content ': moderator'
    end

    scenario 'it show admins and members when its selected' do
      sleep(1)
      visit '/users'
      check('Admin')
      check('Member')
      find('.btn-success').click
      expect(page).to have_content ': admin'
      expect(page).to have_content ': member'
      expect(page).not_to have_content ': moderator'
    end

    scenario 'it show admins and moderators when its selected' do
      sleep(1)
      visit '/users'
      check('Admin')
      check('Moderator')
      find('.btn-success').click
      expect(page).to have_content ': admin'
      expect(page).not_to have_content ': member'
      expect(page).to have_content ': moderator'
    end
  end
end
