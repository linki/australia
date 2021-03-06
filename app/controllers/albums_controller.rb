class AlbumsController < InheritedResources::Base
  access_control do
    allow logged_in
    allow anonymous, :to => [:index, :show]
  end
  
  respond_to :html, :xml, :json
  respond_to :atom, :only => :index

  def index
    @albums = (logged_in? ? Album : Album.published).all(:order => 'starts_at DESC, ends_at DESC', :include => :thumb)
    index!
  end
  
  def show
    @album = Album.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @album.published? || logged_in?
    @photos = @album.photos.all(:order => 'position')
    @comments = @album.comments.all(:order => 'created_at', :include => (logged_in? ? [:user, :commentable] : :user))
    @comment = Comment.new(:user_name => cookies[:user_name])
    @album.increase_view_count!
    show!
  end
  
  def new
    @album = Album.new
    @album.starts_at = @album.ends_at = Date.today
    new!
  end
  
  def bundle
    @album = Album.find(params[:id])
    call_rake 'bundle:album', :id => @album.id
    flash[:notice] = "Bundling Album #{@album.id} in Background..."
    redirect_to @album
  end
end