class VideoRatingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    video_id=params[:video_id]
    judge_id=session[:user_id]
    VideoRating.create(judge_id:judge_id,criteria_id:1,score:params[:criteria_1],video_id:video_id)
    VideoRating.create(judge_id:judge_id,criteria_id:2,score:params[:criteria_2],video_id:video_id)
    VideoRating.create(judge_id:judge_id,criteria_id:3,score:params[:criteria_3],video_id:video_id)
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
