source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.4'
gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'uglifier', '>= 1.3.0'
gem 'rails-i18n', '~> 5.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'settingslogic'
gem 'roo', '~> 2.7.0'

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
gem 'bootstrap', '~> 4.1.3'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails', '4.3.3'
gem 'simple_form', '4.0.0'

# authentication gems
gem 'devise', '~> 4.5.0'
gem 'cancan', '~> 1.6'
gem 'rolify', '~> 5.2'

# images gems
gem 'paperclip', '~> 6.0.0'
gem 'aws-sdk', '~> 3'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
