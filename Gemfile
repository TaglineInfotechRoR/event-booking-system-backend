# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.8'

gem 'rails', '~> 7.1'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rubocop-rails', require: false
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby] ## Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
end

group :development do
  gem 'bullet'
end
