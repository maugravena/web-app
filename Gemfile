source "https://rubygems.org"

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'capybara', '~> 3.40'
  gem "debug", platforms: %i[mri windows]
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
  gem 'webmock'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'omniauth', '~> 2.1', '>= 2.1.1'
gem 'omniauth-cognito-idp', '~> 0.1.1'
gem 'omniauth-google-oauth2', '~> 1.1', '>= 1.1.1'
gem 'omniauth-rails_csrf_protection'
