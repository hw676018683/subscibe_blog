source 'https://ruby.taobao.org'

gem 'rails', '4.2.5'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass'

gem "slim-rails"
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'fabrication'
  gem 'ffaker'

  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'test_after_commit'

  gem 'quiet_assets'

  gem 'pry'
  gem 'pry-byebug'

  gem 'guard-rspec', require: false
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

gem 'devise'

gem 'httparty'
gem 'nokogiri'

gem 'whenever', :require => false

gem 'settingslogic'

gem 'omniauth'
gem 'omniauth-github'

gem 'capybara'
gem 'poltergeist'

# Slack api 封装
gem 'slack-notifier'
# 异常监控
gem 'exception_notification'

gem 'puma'