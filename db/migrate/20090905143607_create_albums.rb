class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.date :starts_at
      t.date :ends_at
      t.references :thumb
      t.references :location
      t.references :user
      t.string :package_file_name
      t.string :package_content_type
      t.integer :package_file_size      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :albums
  end
end
