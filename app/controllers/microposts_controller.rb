class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :micropost, only: [:create, :destroy, :edit, :update]
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
