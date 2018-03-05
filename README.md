# Integration-tests
RoR, Rspec, SitePrism, Capybara, Page Object pattern

Test works only with RoR project, using posgresql database.

## Install gems in Gemfile

```
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'require_all'
  gem 'site_prism', '~> 2.9'
  gem 'capybara-webkit', '~> 1.11', '>= 1.11.1'
  gem 'mailcatcher-api', '0.0.1'
  gem 'rspec-wait', '~> 0.0.8'
  gem 'rspec-rails', '~> 3.1.0'
 ```
## Install Mailcatcher

Install not in the project mailcatcer service. 

```
gem install mailcatcher

```
Run service.
```
mailcatcher
```

To set up your rails app. Adding this to your environments/development.rb

```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
```
## Install Dependencies

```
sudo apt-get install qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb
```

## Run tests

```
rspec spec/
```

## Run for for Jenkins (non gui mode)

```
xvfb-run -a bundle exec rspec spec/ 
```
