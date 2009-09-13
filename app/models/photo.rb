class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :image, :thumbnail
  
  has_attached_file :image,
                    :styles => { :large => "800x600>", :medium => "300x300>", :thumb => "100x100>" }
#                    :storage => :s3,
#                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
#                    :path => ":attachment/:id/:style.:extension"

  belongs_to :album
  
  acts_as_list
  
  def thumbnail
    album && album.thumb == self
  end
  
  def thumbnail=(boolean)
    album.update_attribute(:thumb, boolean == "1" ? self : nil) if album
  end
end
