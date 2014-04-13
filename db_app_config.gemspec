$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "db_app_config/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "db_app_config"
  s.version     = DbAppConfig::VERSION
  s.authors     = ["Bryan Tomlin"]
  s.email       = ["bdtomlin@gmail.com"]
  s.homepage    = "bryantomlin.com"
  s.summary     = "Store app config in database"
  s.description = "Allows you to store your app config in the database so it can be changed without re-deploying. Values are cached with Rails.cache"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.4"
  s.add_dependency "dalli"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry-rails"
end
