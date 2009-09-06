class Photo < ActiveRecord::Base
  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }
#                    :storage => :s3,
#                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
#                    :path => ":attachment/:id/:style.:extension"

  belongs_to :album
end
