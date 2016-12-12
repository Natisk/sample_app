class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # before_action :set_user, only: [:facebook, :twitter]

  def facebook
    auth_info = request.env.dig 'omniauth.auth', 'extra', 'raw_info'
    redirect_to root_path, flash: {error: 'Error from FaceBook!' } and return unless auth_info
    @user = User.find_user_by_oauth uid: auth_info['id'], provider: 'facebook'
    if @user.present?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else @user = User.find_by(email: auth_info['email'])
      if @user.present?
        @user.oauths.create uid: auth_info['id'], provider: 'facebook'
        sign_in_and_redirect @user
        set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      else
        redirect_to new_user_registration_url user_info: {uid: auth_info['id'],
                                                          provider: 'facebook',
                                                          name: auth_info['name'],
                                                          email: auth_info['email']}
      end
    end
  end

  def twitter
    auth_info = request.env.dig 'omniauth.auth', 'extra', 'raw_info'
    redirect_to root_path, flash: {error: 'Error from Twitter!' } and return unless auth_info
    @user = User.find_user_by_oauth uid: auth_info['id'], provider: 'twitter'
    if @user.present?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      redirect_to new_user_registration_url user_info: {uid: auth_info['id'],
                                                        provider: 'facebook',
                                                        name: auth_info['name']}
    end
  end

  def failure
    redirect_to root_path
  end
end