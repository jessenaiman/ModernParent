source "http://rubygems.org"

#ruby "2.1.2"

#gem "airbrake"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem 'jquery-ui-rails'
gem "neat", "~> 1.5.1"
gem "pg"
gem "rack-timeout"
gem "rails", "4.1.4"
gem "recipient_interceptor"
gem "haml-rails"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "title"
gem "uglifier"
gem "unicorn"

gem 'refills'

group :development do
  gem "foreman"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 2.14.0"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "newrelic_rpm", ">= 3.7.3"
end

#paging
gem 'kaminari'

#authentication
gem 'devise'
gem 'doorkeeper'#, '~> 0.6.7'
gem 'rack-cors', :require => 'rack/cors'

#charting
gem "chartkick"
gem "groupdate"
gem "active_median"

gem 'activeadmin', github: 'activeadmin/active_admin'