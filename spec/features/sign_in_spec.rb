require 'spec_helper'

describe 'the signin process', :type => :feature do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    user.confirmed_at= Time.zone.now
  end

  it 'signs me in' do
    visit '/login'
    within('#session') do
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'qwerty'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end