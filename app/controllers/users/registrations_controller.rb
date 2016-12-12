class Users::RegistrationsController < Devise::RegistrationsController

  def new
    if params[:user_info].present?
      build_resource({name: params.dig(:user_info, :name), email: params.dig(:user_info, :email), confirmed_at: params.dig(:user_info, :email) ? Time.now : nil })
      resource.oauths.build uid: params.dig(:user_info, :uid), provider: params.dig(:user_info, :provider)
    else
      build_resource({})
    end
    yield resource if block_given?
    respond_with resource
  end
end
