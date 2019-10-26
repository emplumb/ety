source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '5.0.0.1'

gem 'roo'

gem 'kaminari'

gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'mailgun-ruby', '~>1.1'

gem 'bcrypt', '~> 3.1', '>= 3.1.11'

gem 'rack-attack'

gem 'newrelic_rpm'

gem 'dotenv-rails', groups: [:development, :test]

gem 'simplecov', require: false, group: :test

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'pg', '0.20.0'
end

group :production do
  gem 'pg', '0.20.0'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
