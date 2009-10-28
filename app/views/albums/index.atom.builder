atom_feed(:root_url => albums_url, :url => albums_url(:format => :atom)) do |feed|
  feed.title('Australia')
  feed.updated(@albums.any? ? @albums.first.updated_at : Time.now.utc)

  @albums.each do |album|
    feed.entry(album, :published => (album.published_at || album.created_at).utc) do |entry|
      content = '<p>' + album.description + '</p>'
      content += image_tag(album.thumbnail.image.url(:medium))
      entry.title(album.name)
      entry.content(content, :type => 'html')

      entry.author do |author|
        author.name("Martin Linkhorst")
        author.email("m.linkhorst@googlemail.com")
      end
    end
  end
end