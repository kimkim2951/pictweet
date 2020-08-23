class AddIndexToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :text, length: 32
  end
end
