# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dry-system'
gem 'grape'
gem 'grape-swagger'
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development do
  gem 'byebug'
  gem 'irb', require: false
end
