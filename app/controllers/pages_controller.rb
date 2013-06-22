class PagesController < ApplicationController

  def home
    @user = current_user
    @feeds = @user.feeds

    @feeds.each do |feed|
      Feed.check_for_update(feed)
    end
  end



  def visit_feed
    @feed = Feed.find(params[:id])
    @feed.update_visit_date!

    respond_to do |format|
      format.html
    end
  end

end