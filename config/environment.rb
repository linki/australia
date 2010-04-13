# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "publishable"
  config.gem "aws-s3", :lib => "aws/s3"
  
  config.gem "formtastic"
  config.gem "inherited_resources", :version => '<= 1.0.6'
  config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'
  config.gem "acl9"
  
  config.gem 'delayed_job'
  
  config.gem 'mime-types', :lib => "mime/types"
  
  config.gem "haml"
  config.gem "rubyzip", :lib => 'zip/zip'
  
  config.gem 'bullet'
  
  config.load_paths << File.expand_path(File.join(Rails.root, 'app', 'middleware'))
    
  config.time_zone = 'Brisbane'
end