class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
		@login_type = params[:login_type] || "student"  #default login is for student
		@placeholder = params[:login_type] == "judge" ? "Email" : "UIN"			
	end

	def create
		#If login is judge, check if entered email id is valid and already registered
		login_id = params[:login_id]
		if params[:login_type] == "judge"
			judge = Judge.find_by_email(login_id)
			if judge
				redirect_to(showvideos_path(:judgeid => judgeuser))
				session[:current_user] = judge.id
				session[:current_user_type] = 'judge'
			else
				flash.now[:error] = "Invalid Email Id"
				render :action => :new
			end
		else
			student = Student.find_by_uin(login_id)
			if student
				redirect_to student_dashboard_path(student)
				session[:current_user] = student.id
				session[:current_user_type] = 'student'
			else
				flash.now[:error] = "Invalid UIN"
				render :action => :new
			end
		end
	end

	def destroy
	end
end
