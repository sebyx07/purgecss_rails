$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "purgecss_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "purgecss_rails"
  spec.version     = PurgecssRails::VERSION
  spec.authors     = ["sebi"]
  spec.email       = ["gore.sebyx@yahoo.com"]
  spec.homepage    = "https://www.google.com"
  spec.summary     = "Use PurgeCSS with rails, designed for Asset Pipeline"
  spec.description = "Reduce your css files considerably and improve your users experience"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_development_dependency "rails", "~> 5.2.3"

  spec.add_development_dependency "sqlite3"
end
