class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    micropost_check
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost_deleted"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t "micropost_not_deleted"
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end

  def micropost_check
    if @micropost.save
      flash[:success] = t "micropost_created"
      redirect_to root_url
    else
      flash[:danger] = t "micropost_created_not"
      @feed_items = current_user.feed.page(params[:page]).per Settings.page
      render "static_page/home"
    end
  end
end
