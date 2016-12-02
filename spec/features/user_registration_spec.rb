require 'spec_helper'

describe 'the user registration process', :js do

  context 'user registration' do

    scenario 'registration' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'Name', with: 'Maxim'
        fill_in 'Email', with: 'maxim@example.com'
        fill_in 'Password', with: 'qwerty'
        fill_in 'Password confirmation', with: 'qwerty'
      end
      click_button 'Sign up'

      expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      expect(User.last).to eq( User.find_by(name: 'Maxim', email: 'maxim@example.com') )
    end
  end
end