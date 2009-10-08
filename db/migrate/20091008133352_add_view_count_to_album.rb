class AddViewCountToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :view_count, :integer, :default => 0
  end

  def self.down
    remove_column :albums, :view_count
  end
end
