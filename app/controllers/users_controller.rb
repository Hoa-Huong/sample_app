class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.page
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t "wc_sample_app"
    else
      flash.now[:danger] = t "user_create_fail"
      render :new
    end
  end

  def update
    if @user.update user_params
      flash.now[:success] = t "update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "del_user"
    else
      flash[:danger] = t "del_user_fail"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "not_user"
    redirect_to root_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "login_again"
    redirect_to login_url
  end
end
