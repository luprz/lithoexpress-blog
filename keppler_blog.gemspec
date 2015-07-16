$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "keppler_blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "keppler_blog"
  s.version     = KepplerBlog::VERSION
  s.authors     = ["Gabriel"]
  s.email       = ["gbrlmrllo@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of KepplerBlog."
  s.description = "Engine que integra un blog a Keppler-Admin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "simple_form"
  s.add_dependency "haml_rails"
  s.add_dependency "ckeditor"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "cancancan"
  s.add_dependency "cocoon"
  s.add_dependency "acts-as-taggable-on", "~> 3.4"
  s.add_dependency "bootstrap-tagsinput-rails"

  s.add_development_dependency "sqlite3"
end
