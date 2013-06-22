class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.string :feed_url
      t.datetime :last_modified
      t.datetime :last_visited

      t.timestamps
    end
  end
end
