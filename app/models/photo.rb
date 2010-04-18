class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :image
  
  case APP_CONFIG[:storage]
    when 'amazon_s3'
      has_attached_file :image,
                        :styles => { :large => "900x600>", :medium => "300x300>", :thumb => "100x100>" },
                        :storage => :s3,
                        :s3_credentials => { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'] },
                        :bucket => APP_CONFIG[:bucket],                        
                        :s3_host_alias => APP_CONFIG[:host_alias],
                        :s3_headers => { 'Expires' => 10.years.from_now.httpdate },
                        :url => ":s3_alias_url",
                        :path => ":attachment/:id/:style/:filename"
    else
      has_attached_file :image,
                        :styles => { :large => "900x600>", :medium => "300x300>", :thumb => "100x100>" }
  end

  belongs_to :album
  
  acts_as_list :scope => :album
  
  def name
    image_file_name
  end
end