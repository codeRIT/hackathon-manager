$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hackathon_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hackathon_manager"
  s.version     = HackathonManager::VERSION
  s.authors     = ["Stuart Olivera"]
  s.email       = ["stuart@stuartolivera.com"]
  s.homepage    = "https://github.com/sman591/hackathon_manager"
  s.summary     = "Full-featured application for managing hackathon logistics"
  s.description = "Full-featured application for managing hackathon logistics"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.1"

  s.add_development_dependency "sqlite3"
end
