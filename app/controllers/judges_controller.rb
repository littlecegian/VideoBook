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
    @videos = Judge.find(id).get_videos()
  end

  private

  def judge_params
    params.require(:judge).permit(:first_name, :last_name, :email, :tamu, :preference)
  end

end
