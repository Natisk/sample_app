# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_micropost, only: %i[index create]

  def index
    @comments = @micropost.comments.sort_by(&:created_at)
    respond_to do |format|
      format.json { render :index }
      format.html { redirect_to :back }
    end
  end

  def create
    comment = @micropost.comments.build(comment_params.merge(commenter: current_user))
    if comment.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'Comment created!'
          redirect_to :back
        end
        format.json { render :show, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = comment.errors.full_messages
          redirect_to :back
        end
        format.json { render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment deleted'
          redirect_to :back
        end
        format.json { render json: { message: 'Comment deleted' }, status: :no_content }
      end
    else
      format.html do
        flash[:danger] = comment.errors.full_messages
        redirect_to :back
      end
      format.json { render json: { errors: comment.errors.full_messages }, status: :not_found }
    end
  end

  private

  def get_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

  def comment_params
    params.require(:comment).permit %i[body]
  end
end
