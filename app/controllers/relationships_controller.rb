class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: {followers_count: @user.followers.count, following_count: @user.following.count, relationship_id: Relationship.last.id }, status: :ok }
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: {followers_count: @user.followers.count, following_count: @user.following.count, relationship_id: @user.id }, status: :ok }
    end
  end
end