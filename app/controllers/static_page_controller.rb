class StaticPageController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = Micropost.feed(current_user.id).order_by_create_at
                           .page(params[:page]).per Settings.page
  end

  def help; end

  def about; end
end
