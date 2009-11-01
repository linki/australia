atom_feed(:root_url => albums_url, :url => albums_url(:format => :atom)) do |feed|
  feed.title('Australia')
  feed.updated(@albums.any? ? @albums.first.updated_at : Time.now.utc)

  @albums.each do |album|
    published_at = (album.published_at || album.created_at).utc
    feed.entry(album, :published => published_at, :updated => published_at) do |entry|
      content = '<p>' + album.description + '</p>'
      
      thumbnail = album.thumbnail || album.photos.first
      content += image_tag(thumbnail.image.url(:medium)) if thumbnail
      
      entry.title(album.name)
      entry.content(content, :type => 'html')

      entry.author do |author|
        author.name("Martin Linkhorst")
        author.email("m.linkhorst@googlemail.com")
      end
    end
  end
end