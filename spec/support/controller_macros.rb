module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirmed_at= Time.zone.now
      sign_in user
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirmed_at= Time.zone.now
      user.role= 'admin'
      sign_in user
    end
  end
end