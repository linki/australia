class PhotosController < InheritedResources::Base
  actions :all, :except => [:create, :update]
  
  respond_to :html, :xml, :json, :js

  def create
    @photo = Photo.new(params[:photo])
    @photo.image_content_type = MIME::Types.type_for(@photo.image_file_name).to_s
    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
        format.json { render :json => { :result => 'success', :photo => photo_path(@photo) } }        
        format.js           
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error', :error => @asset.errors.full_messages.to_sentence } }        
        format.js
      end
    end
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.image_content_type = MIME::Types.type_for(@photo.image_file_name).to_s
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
        format.json { render :json => { :result => 'success', :photo => photo_path(@photo) } }        
        format.js                 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error', :error => @asset.errors.full_messages.to_sentence } }
        format.js                
      end
    end
  end
end
