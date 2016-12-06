class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :following, :followers, :edit, :update]

  def index
    @users = User.paginate(page: params[:page] || 1)
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless user_signed_in?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    if current_user.role == 'admin'
      @user = User.find(params[:id])
    else
      redirect_to users_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.role == 'admin'
      User.find(params[:id]).destroy
      flash[:success] = 'User deleted'
      redirect_to users_url
    else
      redirect_to users_url
    end
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end