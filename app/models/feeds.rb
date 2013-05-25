class Feeds < ActiveRecord::Base
  attr_accessible :feed_url, :last_modified, :last_visited, :title, :url
end
