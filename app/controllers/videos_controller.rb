class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
  end

  def edit
  end

  def new
  end

  def create
    video = Video.new(video_params)
    if video.valid?
      video.save!
      flash[:notice] = "Your Video Has been Uploaded"
    else
      flash[:error] = "Errors found in form values"
    end
    redirect_to(student_dashboard_path(video.student))
    # directory = "tmp"
    # name =  params['video_file'].original_filename
    # path = File.join(directory, name)
    # File.open(path, "wb") { |f| f.write(params['video_file'].read)}
    # render :nothing => true
  end

  def update
  end

  def destroy
  end

  def index
  end


  private

  def video_params
    params.require(:video).permit(:student_id, :name, :description, :video, :category_id)
  end
end
