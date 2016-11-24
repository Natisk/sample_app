class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = micropost.comments.build(comment_params.merge(commenter: current_user))
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'Comment created!'
          redirect_to :back
        end
        format.json { render @comment }
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = @comment.errors.full_messages
          redirect_to :back
        end
        format.json { render json: {errors: @comment.errors.full_messages  }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment deleted'
          redirect_to :back
        end
        format.json { render @comment }
      end
    else
      format.html do
        flash[:danger] = @comment.errors.full_messages
        redirect_to :back
      end
      format.json { render json: {errors: @comment.errors.full_messages  }, status: :unprocessable_entity }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
