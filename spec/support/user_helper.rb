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

  def admin_login
      @admin = FactoryGirl.create(:admin)
      visit '/login'
      within('.form-horizontal') do
          fill_in 'Email', with: @admin.email
          fill_in 'Password', with: @admin.password
      end
      click_button 'Log in'
  end

  def moderator_login
      @moderator = FactoryGirl.create(:moderator)
      visit '/login'
      within('.form-horizontal') do
          fill_in 'Email', with: @moderator.email
          fill_in 'Password', with: @moderator.password
      end
      click_button 'Log in'
  end

  def user_logout
    user_login
    sleep(1)
    find('#dropdown').click
    # click_link 'dropdown'
    click_link 'Log out'
  end
end
