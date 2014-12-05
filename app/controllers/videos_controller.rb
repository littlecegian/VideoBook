class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
  end

  def edit
  end

  def new
  end

  def create
    @video = Video.new(video_params)
    if @video.valid?
      @video.save!
      yb = YoutubeUploader::Base.new
      response = yb.upload({:title => @video.name, :description => @video.description, :file => @video.video.path})
      if response.success?
        @video.url = response.data.id
        @video.save!
        flash[:notice] = "Your Video Has been Uploaded"
      else
        @video.destroy
        f = File.open("#{Rails.root.to_s}/log/youtube_write_failures/#{Time.now.to_i}.log", "w+")
        f.write(response)
        f.close()
        flash[:error] = "Error While Uploading to Server. Please try after sometime"
      end
    redirect_to(student_dashboard_path(@video.student))
    else
      flash[:error] = "Errors found in form values"
      render :template => "students/dashboard"
    end
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
