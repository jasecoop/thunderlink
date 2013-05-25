class AddFeedIdToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :feed_id, :integer
  end
end
