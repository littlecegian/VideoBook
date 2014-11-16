class VideoRating < ActiveRecord::Base
  belongs_to :video
  belongs_to :judge
  belongs_to :criteria
end
