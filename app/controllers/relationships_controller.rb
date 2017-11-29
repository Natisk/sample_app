# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow user
    relation_id = Relationship.last.id
    respond_to do |format|
      format.html { redirect_to user }
      format.json { render json: response_json(user.followers.count, user.following.count, relation_id), status: :ok }
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow user
    respond_to do |format|
      format.html { redirect_to user }
      format.json { render json: response_json(user.followers.count, user.following.count, user.id), status: :ok }
    end
  end

  private

  def response_json(followers, following, relation_id)
    {
      followers_count: followers,
      following_count: following,
      relationship_id: relation_id
    }
  end
end
