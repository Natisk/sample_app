class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    micropost = Micropost.find_by(id: params[:micropost_id])
    comment = micropost.comments.build(comment_params.merge(commenter: current_user))
    # comment.commenter = current_user
    if comment.save
      flash[:notice] = 'Comment created!'
    else
      flash[:danger] = comment.errors.messages
    end
    redirect_to :back
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash[:success] = 'Comment deleted'
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
