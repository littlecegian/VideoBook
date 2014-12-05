class JudgesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    judge = Judge.new(judge_params)    
    if(judge.valid?)
      judge.save!
      flash[:notice] = "New Judge Account has been created. Please login to continue"
      redirect_to(root_path)
    else
      flash.now[:error] = "Errors found in form values"
      render :action => :new
    end
  end

  def edit
  end

  def update
  end

  def show
    #@videos = Judge.find(id).get_videos()
    noofvideos = APP_CONFIG[:number_of_videos_per_load]
    #noofvideos = 3
    @judge = Judge.find(params[:id])
    judgepreference = Judge.getpreference(params[:id])
    @idofjudge = params[:id]
    #byebug
    if judgepreference.preference == "all"
        @videolist,@videoinfo = Video.getrandomvideos(noofvideos,"all")
    elsif judgepreference.preference == "categories"
        preferredcategories = JudgeCategory.getpreferredcategories(params[:id])
        @videolist,@videoinfo = Video.getrandomvideos(noofvideos,"categories",preferredcategories)
    elsif judgepreference.preference == "student"
        
    end
    #get_preference(params:)
  end

  private

  def judge_params
    params.require(:judge).permit(:first_name, :last_name, :email, :tamu, :preference)
  end

end
