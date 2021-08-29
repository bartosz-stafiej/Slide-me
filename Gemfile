source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rswag-api'
gem 'rswag-ui', '~> 2.4'
gem 'dry-validation', '~> 0.6.0'
gem 'blueprinter', '~> 0.25'

group :development, :test do
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'rswag-specs'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'factory_bot', '~> 6.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'pry', '~> 0.13.0'
  gem 'pry-byebug', '~> 3.4'
end

group :development do
  gem 'rubocop-rails', '~> 2.11', require: false
  gem 'listen', '~> 3.3'
  gem 'spring'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
