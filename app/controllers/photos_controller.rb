class PhotosController < InheritedResources::Base
  belongs_to :album
  
  respond_to :html, :xml, :json, :js

  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build(params[:photo])
    @photo.image_content_type = MIME::Types.type_for(@photo.image_file_name).to_s
    create! do |success, failure|
      success.html { redirect_to resource_path }
      success.xml  { render :xml => @photo, :status => :created, :location => @photo }
      success.json { render :json => { :result => 'success', :photo => resource_path } }        
      success.js
      failure.html { render :action => "new" }
      failure.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      failure.json { render :json => { :result => 'error', :error => @photo.errors.full_messages.to_sentence } }        
      failure.js
    end
  end

  def update
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
    @photo.image_content_type = MIME::Types.type_for(@photo.image_file_name).to_s
    update! do |success, failure|
      success.html { redirect_to resource_path }
      success.xml  { head :ok }
      success.json { render :json => { :result => 'success', :photo => resource_path } }        
      success.js
      failure.html { render :action => "edit" }
      failure.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      failure.json { render :json => { :result => 'error', :error => @photo.errors.full_messages.to_sentence } }
      failure.js
    end
  end
  
  def update_multiple
    @album = Album.find(params[:album_id])
    params[:photo].each do |id, attributes|
      Photo.update(id, attributes)
    end
    redirect_to album_photos_path(@album)
  end
end
