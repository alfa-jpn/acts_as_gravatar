require 'rubygems'
require 'bundler/setup'
require 'acts_as_gravatar'
require 'cgi'
require 'digest/md5'

RSpec.configure do |config|
  config.mock_framework = :rspec
end
