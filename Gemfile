# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'action_policy', '~> 0.6.0'
gem 'blueprinter', '~> 0.25'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'
gem 'devise-jwt', '~> 0.9.0'
gem 'dry-equalizer', '~> 0.3.0'
gem 'dry-validation', '~> 1.6.0'
gem 'multi_json', '~> 1.11', '>= 1.11.2'
gem 'pagy', '~> 4.11'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 0.4.0'
gem 'rails', '~> 6.1.4'
gem 'rswag-api'
gem 'rswag-ui', '~> 2.4'

group :development, :test do
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'factory_bot', '~> 6.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'pry', '~> 0.13.0'
  gem 'pry-byebug', '~> 3.4'
  gem 'rspec-rails', '~> 4.0'
  gem 'rswag-specs'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.20.0 ', require: false
  gem 'rubocop-performance', '~> 1.11', require: false
  gem 'rubocop-rails', '~> 2.11', require: false
  gem 'spring'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
