source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc2', '< 5.1'
ruby '2.5.0'

group :production do
  # Postgres database on heroku
  gem 'pg'
  # Required for assets pipeline on heroku
  gem 'rails_12factor'
  gem 'faker', '~> 1.6', '>= 1.6.3'
end

group :development do
  gem 'sqlite3', '~> 1.3', '< 1.4'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'nyan-cat-formatter'
  gem 'pry-rails'
  gem 'faker', '~> 1.6', '>= 1.6.3'
  gem 'shoulda'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
end

# Use for encrypting user passwords
gem 'bcrypt'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Bootstrap for style
gem 'bootstrap-sass'
gem 'intercom-rails'
gem 'rails-controller-testing'