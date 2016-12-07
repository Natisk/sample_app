class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :get_micropost, only: [:create, :destroy, :edit, :update]
  before_action :permissions, only: [:destroy, :edit, :update]
  before_action :get_micropost_for_vote, only: [:like_post, :dislike_post]

  def index
    @microposts = Micropost.paginate(page: params[:page])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
  end

  def update
    if @micropost.update_attributes(micropost_params)
      flash[:success] = 'Post updated'
      redirect_back fallback_location: :back
    else
      render 'edit'
    end
  end

  def like_post
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @micropost.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: :back }
      format.json { render json: {like_count: @micropost.get_likes.size, dislike_count: @micropost.get_dislikes.size}, status: :ok }
    end
  end

  def dislike_post
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @micropost.downvote_from current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: :back }
      format.json { render json: {dislike_count: @micropost.get_dislikes.size, like_count: @micropost.get_likes.size}, status: :ok }
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def get_micropost
    @micropost = Micropost.find_by(id: params[:id])
  end

  def get_micropost_for_vote
    @micropost = Micropost.find_by(id: params[:micropost_id])
  end

  def permissions
    if cannot?(params[:action].to_sym, @micropost)
      flash[:danger] = 'Permissions denied!'
      redirect_to(root_path) and return
    end
  end
end
