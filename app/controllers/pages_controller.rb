class PagesController < ApplicationController

  def home
    @user = current_user
    @feeds = @user.feeds
  end

end