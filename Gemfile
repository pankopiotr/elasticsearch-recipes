# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'elasticsearch', '8.6.0'
gem 'jsonapi-serializer', '~> 2.2.0'
gem 'pg', '~> 1.4.6'
gem 'puma', '~> 5.6.5'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails', '~> 3.4.2'
gem 'tzinfo-data', '~> 2.0.6', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'pry'
  gem 'rubocop-rails'
end
