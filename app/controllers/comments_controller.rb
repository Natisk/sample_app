class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @micropost = Micropost.find_by(id: params[:id])
    @comment = @micropost.comments.build(comment_params)
    flash[:success] = 'Comment created!'
    render 'static_pages/home'
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

  def comment
    @comment = Comment.find_by(id: params[:id])
  end
end
