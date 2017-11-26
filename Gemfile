# frozen_string_literal: false

source 'https://rubygems.org'
ruby '2.4.2'

# Networking gems
gem 'http'
gem 'multipart-post'

# Development/Debugging related
gem 'pry' # to run console in production
gem 'rake' # to run console in production

# Web application related
gem 'dry-validation'
gem 'econfig'
gem 'puma'
gem 'roda'
gem 'slim'

# Representers
gem 'multi_json'
gem 'roar'

# Services
gem 'dry-monads'
gem 'dry-transaction'

group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack-test'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'rerun'

  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end
