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
    id = params[:id]
    @judge = Judge.find(id)
  end

  def update
    begin
      judge = Judge.find(params[:id])

      # contestant
      if params[:judge][:preference].eql? "Contestant"

        p_first_name = params[:judge][:contestant_first_name]
        p_last_name = params[:judge][:contestant_last_name]
        contestant = Student.find_by(:first_name=>p_first_name, :last_name=>p_last_name)

        if contestant.nil?
          raise "Error! Student does not exist"
        end

        delete_prev_settings(judge)
        judge_contestant = JudgeContestant.new(judge,contestant)
        judge_contestant.save!
      end

      # categories
      if params[:judge][:preference].eql? "Category"
        
        category_name = params[:judge][:category_name]
        category = Category.find_by(:name=>category_name)        

        delete_prev_settings(judge)
        judge_category = JudgeCategory.new(judge,category)
        judge_category.save!
      end

      # all
      if params[:judge][:preference].eql? "All"
        delete_prev_settings(judge)
      end

      # judge preference
      judge.update_attributes(judge_params)
      judge.save!
      flash[:notice] = "Settings updated successfully."
      redirect_to(judge_path(judge))

    rescue Exception => e
      Rails.logger.debug("#{e.inspect}")
      flash[:notice] = e.message
      redirect_to(edit_judge_path(judge))
    end
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

  def delete_prev_settings(judge)
    delete_prev_categories(judge)
    delete_prev_contestants(judge)
  end

  def delete_prev_categories(judge)
    JudgeCategory.where(:judge_id => judge).destroy_all
  end

  def delete_prev_contestants(judge)
    JudgeContestant.where(:judge_id => judge).destroy_all
  end

  def throwError(message='')
    flash[:notice] = message
    render 'edit'
  end

end
