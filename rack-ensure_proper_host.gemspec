# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/ensure_proper_host/version"

Gem::Specification.new do |s|
  s.name        = "rack-ensure_proper_host"
  s.version     = Rack::EnsureProperHost::VERSION
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/rack-ensure_proper_host"
  s.summary     = "Rack middleware for ensuring only proper hosts get passed to your application"
  s.description = "Rack middleware for ensuring only proper hosts get passed to your application"

  s.rubyforge_project = "rack-ensure_proper_host"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake",            "> 0"
  s.add_development_dependency "bundler",         "> 0"
  s.add_development_dependency "minitest",        "> 2"
  s.add_development_dependency "minitest_should", "~> 0.3.0"
  s.add_development_dependency "rack-test",       "~> 0.6"
    
end
