$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "purgecss_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "purgecss_rails"
  spec.version     = PurgecssRails::VERSION
  spec.authors     = ["sebi"]
  spec.email       = ["gore.sebyx@yahoo.com"]
  spec.homepage    = "https://github.com/sebyx07/purgecss_rails"
  spec.summary     = "PurgeCSS wrapper which can be used with Rails Asset Pipeline"
  spec.description = "Reduce the bloat in your Rails CSS files"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_development_dependency "rails", "~> 5.2.3"

  spec.add_development_dependency "sqlite3"
end
