class RemoveLocationFromDatabase < ActiveRecord::Migration
  def self.up
    remove_column :users, :location_id
    remove_column :albums, :location_id
    
    drop_table :locations
  end

  def self.down
    create_table :locations do |t|
      t.string :name
      t.timestamps
    end
    
    add_column :albums, :location_id, :integer
    add_column :users, :location_id, :integer
  end
end
