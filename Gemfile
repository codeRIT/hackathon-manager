source 'https://rubygems.org'

# Declare your gem's dependencies in hackathon_manager.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem 'pry', group: [:development, :test]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :test do
  gem 'shoulda'
  gem 'minitest-reporters'
  gem 'valid_attribute'
  gem 'factory_bot_rails'
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil
  gem 'rails-controller-testing' # Rails 4 fallback
  gem 'dotenv-rails'
end

group :tools do
  gem 'guard'
  gem 'guard-minitest'
end
