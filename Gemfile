source 'https://rubygems.org'

group :fastlane do
  gem 'fastlane'
  gem 'slather'
  gem 'dotenv'
  gem 'xcodeproj'
  gem 'xcode-install'
  gem 'rake'
end

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
