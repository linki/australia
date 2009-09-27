class AlbumsController < InheritedResources::Base
  before_filter :admin_required, :only => :new
  
  respond_to :html, :xml, :json, :js

  # caches_page :index, :show
  # cache_sweeper :album_sweeper, :only => [:create, :update, :destroy]
    
  def index
    @albums = Album.all(:order => 'starts_at DESC, ends_at DESC')
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