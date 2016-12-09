class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.facebook_omniauth(request.env['omniauth.auth'])
    fail_here
    if @user.present?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      flash[:notice] = 'Current email already was registered'
      # flash[:uid] = request.env['omniauth.auth']['extra']['id']
      # flash[:name] = request.env['omniauth.auth']['extra']['name']
      # flash[:email] = request.env['omniauth.auth']['extra']['email']
      redirect_to new_user_registration_url user_info: {uid: request.env['omniauth.auth']['extra']['id'],
                                            name: request.env['omniauth.auth']['extra']['name'],
                                            email: request.env['omniauth.auth']['extra']['email']}

      # @user = User.new(params[:user_info])
    end
  end

  def twitter
    @user = User.twitter_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end