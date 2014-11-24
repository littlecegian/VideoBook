class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
		@placeholder = params[:login_type] == "judge" ? "Email" : "UIN"
		@login_type = params[:login_type] || "student" #default login is for student
	end

	def create
	end

	def destroy
	end
end
