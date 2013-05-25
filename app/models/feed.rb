class Feed < ActiveRecord::Base
  attr_accessible :feed_url, :last_modified, :title, :url, :last_visited

  def fetch_feed!
   feed = Feedzirra::Feed.fetch_and_parse(feed_url) # probably want some eror handling here
   title = feed.title
   url = feed.url
   last_modified = feed.last_modified
   self #or nil if you like
 end
end
