source "https://rubygems.org"

gem "bootsnap", require: false
gem "kamal", require: false
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.1"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development do
  gem "rubocop"
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
end

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "factory_bot_rails"
  gem "faker", require: true
  gem "rspec-rails", "~> 7.0.0"
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "shoulda-matchers", "~> 6.0"
end
