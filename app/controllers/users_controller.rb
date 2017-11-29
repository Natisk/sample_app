# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update following followers]

  def index
    users = params[:roles].present? ? User.where(role: params[:roles]) : User.all
    @users = users.paginate(page: params[:page] || 1)
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    current_user.role == 'admin' ? set_user : redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.role == 'admin'
      set_user.destroy
      flash[:success] = 'User deleted'
      redirect_to users_url
    else
      redirect_to users_url
    end
  end

  def following
    @title = 'Following'
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[name email role]
  end
end
