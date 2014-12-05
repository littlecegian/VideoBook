class AddFileToVideos < ActiveRecord::Migration
  def change
  	add_attachment :videos, :video
  	add_column :videos, :video_meta, :text
  end
end
