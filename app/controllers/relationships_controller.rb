class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_relationship, only: :destroy
  before_action :load_user_followed, only: :create

  def create
    current_user.follow @user
    respond_to :js
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    respond_to :js
  end

  private

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship

    flash[:danger] = t "not_found_relationship"
    redirect_to root_url
  end

  def load_user_followed
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "not_user"
    redirect_to root_url
  end
end
