class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.references :category, index: true
      t.references :student, index: true
      t.integer :length
      t.string :file_size
      t.string :file_type
      t.datetime :upload_date
      t.text :description

      t.timestamps
    end
    add_index :videos, :url, unique: true
  end
end
