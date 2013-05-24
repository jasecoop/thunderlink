class PagesController < ApplicationController

  def home
    @feeds = Feed.all
  end

end