source 'http://rubygems.org'

gem 'rails', '2.3.5'
gem 'mysql2', '< 0.3'
gem 'pg'
gem 'sqlite3-ruby', :require => 'sqlite3'
  
group :plugins do
  gem 'acl9'
  gem 'acts-as-list',        :require => 'acts_as_list'
  gem 'aws-s3',              :require => 'aws/s3'
  gem 'delayed_job'
  gem 'formtastic'
  gem 'haml'
  gem 'hoptoad_notifier'
  gem 'inherited_resources', '<= 1.0.6'
  gem 'mime-types',          :require => 'mime/types'
  gem 'thin'
  gem 'paperclip'
  gem 'rubyzip',             :require => 'zip/zip'
end

group :development do
  gem 'bullet',          '>= 1.7.6'
  gem 'rails-footnotes'
end

group :test, :cucumber do
  gem 'cucumber'
  gem 'factory_girl'
  gem 'mocha'
  gem 'pickle'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'test-unit'
  gem 'webrat'
end
