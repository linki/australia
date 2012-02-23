require 'zip/zip'
require 'zip/zipfilesystem'
require 'publishable'

class Album < ActiveRecord::Base
  attr_accessible :name, :description, :starts_at, :ends_at, :thumb_id, :published

  case APP_CONFIG[:storage]
    when 'amazon_s3' then
      has_attached_file :package,
                        :storage => :s3,
                        :s3_credentials => { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'] },
                        :bucket => APP_CONFIG[:bucket],                        
                        #:s3_host_alias => APP_CONFIG[:host_alias],
                        #:url => ":s3_alias_url",
                        :url  => ":s3_eu_url",
                        :path => ":attachment/:id/:filename"
                        
    else
      has_attached_file :package,
                        :path => ":rails_root/public/system/:attachment/:id/:filename",
                        :url => "/system/:attachment/:id/:filename"
  end

  validates_presence_of :name
  
  has_many :photos, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :thumb, :class_name => 'Photo'
      
  permalinked
  
  publishable
  
  def thumbnail
    thumb ? thumb : photos.first
  end
  
  def increase_view_count!
    update_attribute(:view_count, (view_count || 0) + 1)
  end
  
  def bundle
    FileUtils.mkdir_p "#{RAILS_ROOT}/tmp/packages"
    bundle_filename = "#{RAILS_ROOT}/tmp/packages/#{name.gsub(/\s/, '-').gsub(/[^\w-]/, '')}.zip"
    begin
      File.delete(bundle_filename)
    rescue Exception
    end

    case APP_CONFIG[:storage]
      when 'amazon_s3' then
        require 'net/http'

        photos.collect do |photo|
          begin
            File.delete("#{RAILS_ROOT}/tmp/packages/#{photo.image_file_name}")
          rescue Exception
          end
        end

        Zip::ZipFile.open(bundle_filename, Zip::ZipFile::CREATE) do |zipfile|
          Net::HTTP.start(APP_CONFIG[:host_alias]) do |http|
            photos.collect do |photo|
              resp = http.get("/#{photo.image.path(:original)}")
              open("#{RAILS_ROOT}/tmp/packages/#{photo.image_file_name}", "w") do |file|
                file.write(resp.body)
              end
              zipfile.add("#{photo.image_file_name}", "#{RAILS_ROOT}/tmp/packages/#{photo.image_file_name}")
            end
          end
        end

        photos.collect do |photo|
          File.delete("#{RAILS_ROOT}/tmp/packages/#{photo.image_file_name}")
        end
      else
        Zip::ZipFile.open(bundle_filename, Zip::ZipFile::CREATE) do |zipfile|
          photos.collect do |photo|
            zipfile.add("#{photo.image_file_name}", photo.image.path(:original))
          end
        end
    end    

    self.package = File.open(bundle_filename)

    File.delete(bundle_filename)

    save!    
  end  
end