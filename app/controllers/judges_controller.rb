class JudgesController < ApplicationController
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
    config=YAML.load_file('config/applicationconfig.yml')
    noofvideos = config["number_of_videos_per_load"]    
    #noofvideos = 3
    judgepreference = Judge.getpreference(params[:judgeid])
    @idofjudge = params[:judgeid]
    #byebug
    if judgepreference.preference == "all"
        @videolist,@videoinfo = Video.getrandomvideos(noofvideos,"all")
    elsif judgepreference.preference == "categories"
        preferredcategories = JudgeCategory.getpreferredcategories(params[:judgeid])
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
