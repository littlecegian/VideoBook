class VideoRatingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    video_id=params[:video_id]
    judge_id=session[:user_id]
    Criteria.all.each do |criteria|
      video = VideoRating.find_or_initialize_by(video_id: video_id, judge_id: judge_id, criteria_id: criteria.id)
      video.score = params[criteria.name.to_sym]
      video.save!
    end
    flash[:success] = "You have rated the video successfully!"
    redirect_to judge_path(judge_id)
  end

  def edit
  end

  def update
  end

  def index
  end

  def new
  end

  def destroy
  end
end
