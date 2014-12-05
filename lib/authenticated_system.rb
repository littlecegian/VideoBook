module AuthenticatedSystem
  protected
    # Returns true or false if the user is logged in.
    # Preloads @current_user with the user model if they're logged in.
    def logged_in?
      !!current_user
    end

    def current_user
    	return nil if session[:user_type].nil?
    	if session[:user_type] == 'judge'
    		@current_user ||= Judge.find(session[:user_id])
    	else
    		@current_user ||= Student.find(session[:user_id])
    	end
    end

end