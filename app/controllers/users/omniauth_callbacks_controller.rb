# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    auth_info = request.env.dig('omniauth.auth', 'extra', 'raw_info')
    return redirect_to root_path, flash: { error: 'Error from FaceBook!' } unless auth_info

    @user = User.find_user_by_oauth(uid: auth_info['id'], provider: 'facebook')
    if @user.present?
      present_user_action(@user, 'Facebook')
    else
      @user = User.find_by(email: auth_info['email'])
      if @user.present?
        present_user_action(@user, 'Facebook') { user.oauths.create(
          uid: auth_info['id'],
          provider: 'facebook',
          link: auth_info['link']
        ) }
      else
        redirect_to new_user_registration(
          auth_info['id'],
          'facebook',
          auth_info['name'],
          auth_info['link'],
          auth_info['email']
        )
      end
    end
  end

  def google_oauth2
    auth_info = request.env.dig('omniauth.auth', 'extra', 'raw_info')
    return redirect_to root_path, flash: { error: 'Error from Google!' } unless auth_info

    @user = User.find_user_by_oauth(uid: auth_info['sub'], provider: 'google_oauth2')
    if @user.present?
      present_user_action(@user, 'Google')
    else
      @user = User.find_by(email: auth_info['email'])
      if @user.present?
        present_user_action(@user, 'Google') { user.oauths.create(
          uid: auth_info['sub'],
          provider: 'google_oauth2',
          link: auth_info['profile']
        ) }
      else
        redirect_to new_user_registration(
          auth_info['sub'],
          'google_oauth2',
          auth_info['name'],
          auth_info['profile'],
          auth_info['email']
        )
      end
    end
  end

  def vk
    auth_raw_info = request.env.dig('omniauth.auth', 'extra', 'raw_info')
    auth_info = request.env.dig('omniauth.auth', 'info')
    return redirect_to root_path, flash: {error: 'Error from Vk!' } unless auth_info

    @user = User.find_user_by_oauth uid: auth_raw_info['id'], provider: 'vk'
    case
      when @user.present?
        present_user_action(@user, 'Vk')
      when current_user.present?
        present_user_action(current_user, 'Vk') { user.oauths.create(
          uid: auth_raw_info['id'],
          provider: 'vk',
          link: "https://vk.com/id#{auth_info['user_id']}"
        ) }
      else
        redirect_to new_user_registration(
          auth_raw_info['id'],
          'vk',
          auth_info['name'],
          "https://vk.com/id#{auth_info['user_id']}"
        )
    end
  end

  def twitter
    auth_info = request.env.dig('omniauth.auth', 'extra', 'raw_info')
    link_url = request.env.dig('omniauth.auth', 'info', 'urls', 'Twitter')
    return redirect_to root_path, flash: {error: 'Error from Twitter!' } unless auth_info

    @user = User.find_user_by_oauth uid: auth_info['id'], provider: 'twitter'
    case
      when @user.present?
        present_user_action(@user, 'Twitter')
      when current_user.present?
        present_user_action(current_user, 'Twitter') { user.oauths.create(
          uid: auth_info['id'],
          provider: 'twitter',
          link: link_url
        ) }
      else
        redirect_to new_user_registration(auth_info['id'], 'twitter', auth_info['name'], link_url)
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def new_user_registration(uid, provider, name, link, email = nil)
    new_user_registration_url(user_info: { uid: uid, provider: provider, name: name, link: link, email: email })
  end

  def present_user_action(user, provider)
    yield if block_given?
    sign_in_and_redirect user
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
  end
end
