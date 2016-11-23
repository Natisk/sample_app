class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :micropost, only: [:create, :destroy, :edit, :update, :like_post, :dislike_post]
  before_action :permissions, only: [:destroy, :edit, :update]


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
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def like_post
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @micropost.liked_by current_user
    respond_to do |format|
      format.json { render json: {like_count: @micropost.get_likes.size},  status: :ok }
    end
    # redirect_to :back
  end

  def dislike_post
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @micropost.downvote_from current_user
    respond_to do |format|
      format.json { render json: {dislike_count: @micropost.get_dislikes.size}, status: :ok }
    end
    # redirect_to :back
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

  def micropost
    @micropost = Micropost.find_by(id: params[:id])
  end

  def permissions
    if cannot?(params[:action].to_sym, @micropost)
      flash[:danger] = 'Permissions denied!'
      redirect_to(root_path) and return
    end
  end
end
