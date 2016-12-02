  module UserHelper
    def user_login
        @user = FactoryGirl.create(:user)
        visit '/login'
        within('.form-horizontal') do
          fill_in 'Email', with: @user.email
          fill_in 'Password', with: @user.password
        end
        click_button 'Log in'
    end

    def user_logout
        user_login
        click_link 'Log out'
    end
  end
