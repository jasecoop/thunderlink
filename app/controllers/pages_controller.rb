class PagesController < ApplicationController

  def home
    @user = current_user
    @feeds = @user.feeds

    @feeds.each do |feed|
      Feed.check_for_update(feed)
    end

  end

end