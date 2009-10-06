class AddPublishedAtToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :published_at, :datetime
    Album.reset_column_information
    Album.all.each do |album|
      album.update_attribute(:published_at, Time.now)
    end
  end

  def self.down
    remove_column :albums, :published_at
  end
end
