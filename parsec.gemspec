# encoding: utf-8

Gem::Specification.new do |s|
  s.name               = "parsec"
  s.version            = "0.1.0"
  s.platform           = Gem::Platform::RUBY
  s.authors            = ["Nilton Vasques"]
  s.email              = ["nilton.vasques@gmail.com"]
  s.description        = %q{Parsec}
  s.homepage           = %q{https://github.com/niltonvasques/parsec}
  s.summary            = %q{A gem to evaluate math equations using a lighter and faster version of the muparsex C++ library}
  s.files              = ["lib/parsec.rb", "lib/string_to_boolean_refinements.rb"]
  s.test_files         = ["test/test_parsec.rb"]
  s.require_paths      = ["lib"]
  s.license            = "mit"

  s.add_development_dependency "mocha", "~> 0.3"
  s.add_development_dependency "rake", "~> 12.1"
  s.add_development_dependency "minitest", "~> 5.10"
end
