# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.8'

gem 'rails', '~> 7.1'

gem 'bcrypt', '~> 3.1.20'
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'jsonapi-serializer', '~> 2.2.0'
gem 'jwt', '~> 2.3', '>= 2.3.0'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby] ## Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'pry', '~> 0.14.2'
  # Code Linter Check
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'bullet'
end
