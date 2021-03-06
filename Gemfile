source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.4'
gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.12'
gem 'uglifier', '>= 1.3.0'
gem 'rails-i18n', '~> 5.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'settingslogic'

# seo
gem 'meta-tags'
gem 'friendly_id', '~> 5.2.4'

# xlsx
gem 'roo', '~> 2.7.0'
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails'

# deploy
gem 'capistrano'
gem 'capistrano-bundler'
gem 'capistrano3-puma', '1.2.1'
gem 'capistrano-rails'
gem 'capistrano-rvm'

# front end gems
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'browser', '~>2.5.0'
gem 'bootstrap', '~> 4.3.1'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails', '4.3.3'
gem 'simple_form', '4.0.0'
gem 'rb-readline'

# authentication gems
gem 'devise', '~> 4.7.1'
gem 'cancancan', '~> 3'
gem 'rolify', '~> 5.2'

# images gems
gem 'paperclip', '~> 6.0.0'
gem 'aws-sdk', '~> 3'

group :development, :test do
  gem 'pry'
  gem 'factory_bot_rails'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
