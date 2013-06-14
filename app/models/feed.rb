class Feed < ActiveRecord::Base
  attr_accessible :feed_id, :feed_url, :last_modified, :title, :url, :last_visited, :user_id

  belongs_to :user

  def fetch_feed!
   feed = Feedzirra::Feed.fetch_and_parse(feed_url) # probably want some eror handling here
   self.title = feed.title
   self.url = feed.url
   self.last_modified =  feed.last_modified
   self #or nil if you like
  end

  def self.check_for_update(feed)

    fetched_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)

    entry = fetched_feed.entries.first
    feed.last_modified = entry.published

    # fetched_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
    # updated_feed = Feedzirra::Feed.update(fetched_feed)
    # if updated_feed.updated?
    #   feed.last_modified  = updated_feed.last_modified

    #   # count = updated_feed.new_entries.count
    #   # feed.last_modified  = updated_feed.last_modified
    #   # feed.title = count
    # else
    #   nil
    # end
  end

 def update_visit_date!
  date = Time.now
  update_attribute(:last_visited, date)
  self
 end

end
