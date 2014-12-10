class ChangeScoreTypeInVideoRatings < ActiveRecord::Migration
  def self.up
  	change_column :video_ratings, :score, :integer
  end

  def self.down
  	change_column :video_ratings, :score, :integer
  end
end
