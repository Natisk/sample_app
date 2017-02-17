class OmniauthController < ApplicationController
  before_action :authenticate_user!

  def destroy
    oauth = Oauth.find_by(id: params[:id])
    flash[:success] = 'Account unsigned'
    oauth.destroy
    redirect_to edit_user_registration_url
  end
end
