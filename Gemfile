source 'https://rubygems.org'
ruby '2.2.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Using React for frontend developement
gem 'react-rails'

# Using Bootstrap 2.3.2
gem 'twitter-bootstrap-rails', '~> 2.2.8'
gem 'bootstrap-select-rails'
gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'bootswatch-rails' #This gem is meant to be used with bootstrap-sass. It gives you complete scss versions of bootswatches for use in your Rails asset pipeline, just like bootstrap-sass gives you scss version of bootstrap itself.


# Using Device and CanCan for authentication
gem 'devise'
gem 'cancan'

# Using Simple Form to simplified forms
gem 'simple_form'

# Using Prawn for reports
gem 'prawn'
gem 'prawn-table'

# Using PaperClip for file attachment management and Dropbox API to store it
gem 'paperclip', '~> 4.2'
gem 'paperclip-dropbox'

# Using ActiveAdmin as administratin framework for administration users
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
#gem 'kaminari'

# Using Figaro for simple, Heroku-friendly Rails app configuration using ENV and a single YAML file
gem 'figaro'

# Using Will_Paginate as a pagination library
gem "will_paginate", '~> 3.0'
gem 'will_paginate-bootstrap', '~> 0.2.5'

# Using Rolify as a role managment library
gem 'rolify'

# Using Coutry Selectas a simple helper to get an HTML select list of countries using the ISO 3166-1 standard.
gem 'country_select'

# Using PayPal SDK
gem 'paypal-sdk-core', '~> 0.3.2'
gem 'paypal-sdk-rest', '~> 1.3.3'

# Using Mercado Pago SDK
#gem 'mercadopago-sdk'

# Using Remotipart to use remote =>true in form
gem 'remotipart', '~> 1.3.1'

group :production do
  # Use Postgresql for production
  gem 'pg'
  gem 'rails_12factor'
  gem 'execjs'
  gem 'therubyracer'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', platform: :mri
  # Use sqlite3 as the database for Active Record
  #gem 'sqlite3'
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'sqlite3'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]