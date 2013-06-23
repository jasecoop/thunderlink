class PagesController < ApplicationController

  def home
    @user = current_user
    @feeds = @user.feeds

    @feeds.each do |feed|
      Feed.check_for_update(feed)
    end

    gon.feed = @feeds
  end

  def visit_feed
    @feed = Feed.find(params[:id])
    @feed.update_visit_date!

    respond_to do |format|
      format.html
    end
  end

  def add_thunderlink
    respond_to do |format|
      format.js
    end
  end

end