class PhotosController < InheritedResources::Base
  respond_to :html, :xml, :json
  
  belongs_to :album
end
