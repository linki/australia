class UsersController < InheritedResources::Base
  before_filter :admin_required
    
  respond_to :html, :xml, :json
end