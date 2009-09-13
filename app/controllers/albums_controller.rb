class AlbumsController < InheritedResources::Base
  respond_to :html, :xml, :json, :js
  
  def index
    @albums = Album.all(:order => 'created_at')
    index!
  end
  
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.all(:order => 'position')
    @comments = @album.comments.all(:order => 'created_at')
    @comment = Comment.new(:user_name => cookies[:user_name])
    show!
  end
  
  def new
    @album = Album.new
    @album.starts_at = @album.ends_at = Date.today
  end
end