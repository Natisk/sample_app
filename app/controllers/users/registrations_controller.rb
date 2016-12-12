class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

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

  # POST /resource
  # def create
  #   fail_here
  #   if user_info.present?
  #     build_resource(id: user_info.id, name: user_info.name, email: user_info.email, password: Faker.password(8, 16))
  #     resource.save
  #   else
  #     super
  #   end
  # end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end
  #
  # # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
