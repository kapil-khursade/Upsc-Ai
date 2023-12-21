source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", "~> 7.1.2"
gem "pg", "~> 1.1"
gem "puma", "~> 6.4.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "activeadmin"
gem "devise"
# gem "delayed_job_active_record"
# gem "daemons"
# gem "delayed_job_web"
# gem "httparty"
# gem "caxlsx"
# gem "caxlsx_rails"
gem "carrierwave", ">= 3.0.0.beta", "< 4.0"
# gem "multi_logger"
# gem "puma-daemon"
# gem "whenever", require: false
gem "activeadmin_addons"
gem 'cancancan'
gem 'active_admin_flat_skin'
gem 'font-awesome-rails'
# gem 'active_skin'
# gem 'arctic_admin'
gem 'sidekiq'
gem 'razorpay'


group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
