source 'https://rubygems.org'

group :fastlane do
  gem 'fastlane'
  gem 'slather'
  gem 'dotenv'
  gem 'xcodeproj'
  gem 'xcode-install'
  gem 'danger', '~> 8.6'
  gem 'danger-rubocop', '~> 0.10'
  gem 'rake'
end

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
