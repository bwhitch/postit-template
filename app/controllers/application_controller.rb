class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:id]) if session[:id]
  	#note after the = is what we need above.  
    #the ||= is an or equals statement and allows us to not repeatedly hit db
  end

  def logged_in?
  	!!current_user
  end

  def require_user
   if !logged_in?
   	flash[:error] = "Not available until logged in."
   	redirect_to root_path 
  end
 end
end
