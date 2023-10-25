Gem::Specification.new do |s|
  s.name                  = 'parsecs'
  s.version               = '0.13.1'
  s.platform              = Gem::Platform::RUBY
  s.authors               = ['Nilton Vasques', 'Victor Cordeiro', 'Beatriz Fagundes']
  s.email                 = ['nilton.vasques@gmail.com', 'victorcorcos@gmail.com', 'beatrizsfslima@gmail.com']
  s.description           = 'Parsecs is a gem to evaluate equations using a lighter and extented version of the muparserx C++ library'
  s.homepage              = 'https://github.com/oxeanbits/parsec'
  s.summary               = 'A gem to evaluate equations using muparserx C++ library'
  s.files                 = ['lib/parsec.rb', 'lib/string_to_boolean_refinements.rb', 'ext/libnativemath/libnativemath.i',
                             'ext/libnativemath/libnativemath.cpp', 'ext/libnativemath/libnativemath.h']
  s.test_files            = ['test/test_parsec.rb']
  s.require_paths         = ['lib', 'ext/libnativemath', '.']
  s.required_ruby_version = '>= 2.0'
  s.license               = 'MIT'
  s.requirements          << 'swig' # >= 4.0.2
  s.requirements          << 'cmake'

  s.add_development_dependency 'minitest', '~> 5.10'
  s.add_development_dependency 'rake', '~> 12.1'
  s.extensions = %w[ext/libnativemath/extconf.rb]
end
