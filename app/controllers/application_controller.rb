# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  helper_method :logged_in?
  
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  
  private

  def access_denied
    if current_user
      flash[:error] = 'You have unsufficient rights.'
    else
      flash[:error] = 'Access denied. Try to log in first.'
    end
    redirect_to login_path
  end
  
  def current_user
    logged_in? || nil
  end
  
  def logged_in?
    session[:password] == PASSWORD
  end
end
