source 'http://rubygems.org'
source 'http://gems.rubyinstaller.org' # only for mongrel v1.1.6 and mysql 2.8.1.1, that are needed for ruby 1.9.x and also usable in 1.8.7

gem 'rails', '2.3.5'
gem 'mysql', '>= 2.8.1.1'
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
  gem 'mongrel',             '>= 1.1.6'
  gem 'paperclip'
  gem 'publishable'
  gem 'rubyzip',             :require => 'zip/zip'
  gem 'test-unit',           '1.2.3'
end

group :development do
  gem 'bullet',          '>= 1.7.6'
  gem 'rails-footnotes'
end

group :test, :cucumber do
  gem 'cucumber',     '0.4.4'
  gem 'factory_girl', '1.2.3'
  gem 'mocha',        '0.9.8'
  gem 'pickle',       '0.2.1'
  gem 'rspec',        '1.3.0'
  gem 'rspec-rails',  '1.3.2'
  gem 'test-unit',    '1.2.3'  
  gem 'webrat',       '0.6.0'
end
