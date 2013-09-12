source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
gem "bcrypt-ruby", :require => "bcrypt"
gem 'kaminari'
gem 'simple_form'
gem 'jquery-rails'
gem "friendly_id", "~> 4.0.9"

group :sqlite do
  gem 'sqlite3'
end

group :mysql do
  gem 'mysql2'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'therubyracer'
  gem 'uglifier'
end

group :development do
  gem 'pry-rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mocha', :require => false
end

group :test, :development do
  gem 'debugger'
end
