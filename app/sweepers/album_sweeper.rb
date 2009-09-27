class AlbumSweeper < ActionController::Caching::Sweeper
  observe Album
  
  def after_save(album)
    expire_cache(album)
  end
  
  def after_destroy(album)
    expire_cache(album)
  end
  
  def expire_cache(album)
    expire_page albums_path
    expire_page album_path(album)
  end
end