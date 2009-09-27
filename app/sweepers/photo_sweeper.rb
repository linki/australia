class PhotoSweeper < ActionController::Caching::Sweeper
  observe Photo
  
  def after_save(photo)
    expire_cache(photo.album)
  end
  
  def after_destroy(photo)
    expire_cache(photo.album)
  end
  
  def expire_cache(album)
    expire_page albums_path
    expire_page album_path(album)
  end
end