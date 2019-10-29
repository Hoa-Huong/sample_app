class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate(params[:session][:password])
      login_remember
    else
      flash.now[:danger] = t "login_fail"
      render :new
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
end
