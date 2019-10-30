class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      actived_user
    else
      flash.now[:danger] = t "login_fail"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def login_remember
    session = params[:session]
    log_in @user
    session[:remember_me] == Settings.rem_me ? remember(@user) : forget(@user)
    redirect_back_or @user
  end

  def find_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash[:danger] = t "not_user"
    redirect_to root_url
  end

  def actived_user
    if @user.activated?
      login_remember
    else
      flash[:danger] = t "message_not_active"
      redirect_to root_url
    end
  end
end
