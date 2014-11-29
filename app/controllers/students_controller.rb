class StudentsController < ApplicationController
  skip_before_filter :verify_authenticity_token  

  def new
  end

  def create
    student = Student.new(student_create_params)
    if(student.valid?)
      student.save!
      flash[:notice] = "New Student Account has been created. Please login to continue"
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
  end

  def dashboard
  end

  private

  def student_create_params
    params.require(:student).permit(:first_name, :last_name, :email, :uin)
  end
end
