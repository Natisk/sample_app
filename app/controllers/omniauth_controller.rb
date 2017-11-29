# frozen_string_literal: true

class OmniauthController < ApplicationController
  before_action :authenticate_user!

  def destroy
    oauth = Oauth.find(params[:id])
    oauth.destroy
    flash[:success] = 'Account unsigned'
    redirect_to edit_user_registration_url
  end
end
