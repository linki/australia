class AlbumsController < InheritedResources::Base
  before_filter :admin_required, :except => [:index, :show]
  
  respond_to :html, :xml, :json

  # caches_page :index, :show
  # cache_sweeper :album_sweeper, :only => [:create, :update, :destroy]
    
  def index
    @albums = (admin? ? Album : Album.published).all(:order => 'starts_at DESC, ends_at DESC', :include => [:photos, :comments])
    index!
  end
  
  def show
    @album = Album.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @album.published? || admin?
    @photos = @album.photos.all(:order => 'position')
    @comments = @album.comments.all(:order => 'created_at', :include => :user)
    @comment = Comment.new(:user_name => cookies[:user_name])
    show!
  end
  
  def new
    @album = Album.new
    @album.starts_at = @album.ends_at = Date.today
  end
end