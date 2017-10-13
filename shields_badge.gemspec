# encoding: utf-8

Gem::Specification.new do |s|
  s.name               = "shields-badge"
  s.version            = "0.1.0"
  s.platform           = Gem::Platform::RUBY
  s.authors            = ["Nilton Vasques"]
  s.email              = ["nilton.vasques@gmail.com"]
  s.description        = %q{Shields Badget Simplecov Formatter}
  s.homepage           = %q{https://github.com/niltonvasques/simplecov-shields-badge}
  s.summary            = %q{A gem to generate a badge from simplecov coverage result, using shields.io platform and publish the badge to gh-pages}
  s.files              = ["lib/shields_badge.rb"]
  s.test_files         = ["test/test_shields_badge.rb"]
  s.require_paths      = ["lib"]
  s.license            = "mit"

  s.add_dependency "simplecov", "~> 0.15"

  s.add_development_dependency "mocha", "~> 0.3"
  s.add_development_dependency "rake", "~> 12.1"
  s.add_development_dependency "minitest", "~> 5.10"
end
