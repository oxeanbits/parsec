# encoding: utf-8

Gem::Specification.new do |s|
  s.name               = "shields-badge"
  s.version            = "0.1.0"
  s.platform           = Gem::Platform::RUBY
  s.authors            = ["Nilton Vasques"]
  s.email              = ["nilton.vasques@gmail.com"]
  s.description        = %q{Shields Badget Simplecov Formatter}
  s.homepage           = %q{https://github.com/niltonvasques/simplecov-shields-badge}
  s.summary            = %q{Shields Badget Simplecov Formatter}
  s.files              = ["lib/shields_badge.rb"]
  s.test_files         = ["test/test_shields_badge.rb"]
  s.require_paths      = ["lib"]

  s.add_dependency "url"
  s.add_dependency "json"
  s.add_dependency "simplecov"

  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
end
