class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :album_name, :location_name, :image
  
  belongs_to :album
  belongs_to :location
  
  getter_and_setter_for :album => :name,
                        :location => :name
                        
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }                        
end
