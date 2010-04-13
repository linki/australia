class AddCommentsCount < ActiveRecord::Migration
  def self.up
    add_column :albums, :comments_count, :integer, :default => 0

    Album.reset_column_information
    Album.all.each do |album|
      Album.update_counters album.id, :comments_count => album.comments.length
    end
  end

  def self.down
    remove_column :albums, :comments_count
  end
end
