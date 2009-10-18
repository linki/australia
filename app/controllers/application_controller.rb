# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  helper_method :admin?
  
  private
  
  def admin?
    session[:password] == PASSWORD
  end
  
  def admin_required
    return true if admin?
    flash[:error] = "You must be logged in to access this page."
    redirect_to root_path
    false
  end
end
