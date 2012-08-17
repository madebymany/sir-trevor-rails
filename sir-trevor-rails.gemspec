require File.expand_path("../lib/sir-trevor/version", __FILE__)

Gem::Specification.new do |s|
  
  s.name        = 'sir-trevor-rails'
  s.version     = SirTrevor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2012-08-15'
  s.summary     = "sir-trevor-rails-#{s.version}"
  s.description = "A structured text editor."
  s.authors     = ["Andrew Sprinz", "Chris Bell"]
  s.email       = 'chris@madebymany.com'
  s.homepage    = 'https://github.com/madebymany/sir-trevor-rails'

  s.rubyforge_project         = "sir-trevor-rails"
  s.required_rubygems_version = "> 1.3.6"

  s.add_dependency "activesupport" , ">= 3.0.7"
  s.add_dependency "rails"         , ">= 3.0.7"
  s.add_dependency "jquery-rails"

  s.add_dependency "redcarpet", "~> 2.0.1"
  s.add_dependency 'twitter-text', '~> 1.4'

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

end