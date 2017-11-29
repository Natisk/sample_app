# frozen_string_literal: true

require 'spec_helper'

describe 'relationships', :js do
  before { user_login }
  let(:user) { FactoryBot.create(:user) }

  scenario 'follow and unfollow user' do
    sleep(1)
    visit '/users/' + "#{user.id}"
    click_button 'Follow'
    within ('#following') do
      expect(page).to have_content '0'
    end
    within ('#followers') do
      expect(page).to have_content '1'
    end
    sleep(1)
    click_button 'Unfollow'
    within ('#following') do
      expect(page).to have_content '0'
    end
    within ('#followers') do
      expect(page).to have_content '0'
    end
  end
end
