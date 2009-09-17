class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :image
  
  has_attached_file :image,
                    :styles => { :large => "800x600>", :medium => "300x300>", :thumb => "100x100>" }
                    # :storage => :s3,
                    # :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                    # :path => ":attachment/:id/:style/:filename"

  belongs_to :album
  
  acts_as_list
  
  def name
    image_file_name
  end
end
