class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
		@login_type = params[:login_type] || "student"  #default login is for student
		@placeholder = params[:login_type] == "judge" ? "Email" : "UIN"			
	end

	def create

		#If login is judge, check if entered email id is valid and already registered
		if params[:login_type] == "judge"
			emailid = params[:value]		
			if  emailid =~ EmailRegex::EMAIL_ADDRESS_REGEX  				 
   				 judgeuser = Judge.isjudgepresent(emailid)   				
   				 if judgeuser
				 	redirect_to(showvideos_path(:judgeid => judgeuser))
				 else
					flash.now[:error] = "Please register with your email!"  
					render :action => :new
				 end    						
			else
				flash.now[:error] = "Please enter a valid email address!"  
				render :action => :new    			
			end
			
		end

	end

	def destroy
	end
end
