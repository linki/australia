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
  
  acts_as_list
  
  def name
    image_file_name
  end
end



 a.photos.each {|p| p.image = File.open("#{RAILS_ROOT}/public/system/images/#{p.id}/original/#{p.image_file_name}"); p.save!; puts p.id }
 
=> #<File:/home/martin/www/australia/releases/20091001075601/public/system/images/1055/original/IMG_1934.JPG>
>> p.save!
=> true
