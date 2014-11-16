class CreateVideoRatings < ActiveRecord::Migration
  def change
    create_table :video_ratings do |t|
      t.references :video, index: true
      t.references :judge, index: true
      t.references :criteria, index: true
      t.decimal :score, precision: 10, scale: 2

      t.timestamps
    end
  end
end
