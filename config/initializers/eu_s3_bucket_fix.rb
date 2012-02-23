# http://www.conandalton.net/2011/02/paperclip-s3-and-european-buckets.html
require 'aws/s3'
AWS::S3::DEFAULT_HOST = 's3-eu-west-1.amazonaws.com'
Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-west-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
}