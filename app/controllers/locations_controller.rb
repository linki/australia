class LocationsController < InheritedResources::Base
  access_control do
    allow logged_in
  end
  
  respond_to :html, :xml, :json
end
