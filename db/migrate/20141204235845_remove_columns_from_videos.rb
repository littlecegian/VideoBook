class RemoveColumnsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :length, :integer
    remove_column :videos, :file_size, :string
    remove_column :videos, :file_type, :string
    remove_column :videos, :upload_date, :datetime
  end
end
