class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :image
  
  has_attached_file :image,
                    :styles => { :large => "800x600>", :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                    :s3_host_alias => YAML.load_file("#{RAILS_ROOT}/config/amazon_s3.yml")[RAILS_ENV]['host_alias'],
                    :s3_headers => { 'Expires' => 10.years.from_now.httpdate },
                    :url => ":s3_alias_url",
                    :path => ":attachment/:id/:style/:filename"

  belongs_to :album
  
  acts_as_list :scope => :album
  
  def name
    image_file_name
  end
  
  # handle_asynchronously :destroy
end