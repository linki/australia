# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "publishable", :source => "http://gemcutter.org", :version => '>=0.1.1'
  config.gem "aws-s3", :lib => "aws/s3"
  
  config.gem "justinfrench-formtastic", :lib => 'formtastic', :source => 'http://gems.github.com'
  config.gem "josevalim-inherited_resources", :lib => 'inherited_resources', :source => 'http://gems.github.com'
  config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'
  config.gem "acl9", :lib => "acl9", :source => "http://gemcutter.org"
  
  config.gem 'collectiveidea-delayed_job', :lib => 'delayed_job', :source => 'http://gems.github.com'
  
  config.gem 'mime-types', :lib => "mime/types"
  
  config.gem "haml", :source => "http://gemcutter.org"
  config.gem "rubyzip", :lib => 'zip/zip', :source => "http://gemcutter.org"  
  
  config.load_paths << File.expand_path(File.join(Rails.root, 'app', 'middleware'))
    
  config.time_zone = 'Brisbane'
end