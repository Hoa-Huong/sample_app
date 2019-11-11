class FollowsController < ApplicationController
  before_action :load_user, only: %i(following followers)

  def following
    @title = t "following"
    @users = @user.following.page(params[:page]).per Settings.page
    render "users/show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.page(params[:page]).per Settings.page
    render "users/show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t "not_user"
    redirect_to root_url
  end
end
