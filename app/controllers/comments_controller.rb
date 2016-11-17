class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:id])
    @comment = @micropost.comments.create(comment_params)
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to request.referrer || root_url
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
