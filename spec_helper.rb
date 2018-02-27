ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../../config/environment', __FILE__)
require 'rspec/rails'
require "rspec/wait"
require 'require_all'
require 'site_prism'
require 'capybara-webkit'
require 'faker'
require 'capybara'
require 'mailcatcher/api'
require 'net/http'
require 'uri'

require_all 'spec/pages'
require_all 'spec/support'

RSpec.configure do |config|
  config.include Helpers
  # config.full_backtrace = true

  config.before(:all) do
    Capybara.page.driver.browser
  end

  config.after(:all) do
    Capybara.reset_sessions!
  end
end

MailCatcher::API.configure do |config|
  config.server = 'http://127.0.0.1:1080'
end

Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app, Capybara::Webkit::Configuration.to_hash)
end

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
  config.skip_image_loading
end

Capybara.configure do |config|
  config.default_driver = :webkit
  config.javascript_driver = :webkit
  # config.default_max_wait_time = 10
  # config.ignore_hidden_elements = false
end
