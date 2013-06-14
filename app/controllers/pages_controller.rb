class PagesController < ApplicationController

  def home
    @user = current_user
    @feeds = @user.feeds

    last_visit = Feed.order("last_visited").last.last_visited

    @feeds_hot = Feed.where("last_modified > ?", last_visit)


    @feeds_cold = @user.feeds.order('DATE(last_visited)')

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