class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :require_login, except: [:destroy]

	def new
		if logged_in?
			if current_user.is_a? Student
				redirect_to(student_dashboard_path(current_user))
			else
				redirect_to(judge_path(current_user))
			end
			return
		end
		@login_type = params[:login_type] || "student"  #default login is for student
		@placeholder = "Email"			
	end

	def create
		#If login is judge, check if entered email id is valid and already registered
		login_id = params[:login_id]
		if params[:login_type] == "judge"
			judge = Judge.find_by_email(login_id)
			if judge
				redirect_to judge_path(judge)
				session[:user_id] = judge.id
				session[:user_type] = 'judge'
			else
				flash.now[:error] = "Invalid Email Id"
				render :action => :new
			end
		else
			student = Student.find_by_email(login_id)
			if student
				redirect_to student_dashboard_path(student)
				session[:user_id] = student.id
				session[:user_type] = 'student'
			else
				flash.now[:error] = "Invalid UIN"
				render :action => :new
			end
		end
	end

	def destroy
		session[:user_id] = nil
		session[:user_type] = nil
		redirect_to root_path
	end
end
