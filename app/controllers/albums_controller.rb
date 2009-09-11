class AlbumsController < InheritedResources::Base
  respond_to :html, :xml, :json, :js
  
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.all(:order => 'position')
    @comments = @album.comments.find(:all, :order => 'created_at DESC')
    @comment = Comment.new
    show!
  end
end