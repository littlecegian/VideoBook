class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
		@placeholder = "UIN"
		@login_type = params[:login_type] || "student"
	end

	def create
		byebug
	end

	def destroy
	end
end
