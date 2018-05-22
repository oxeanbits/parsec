Gem::Specification.new do |s|
  s.name               = 'parsec'
  s.version            = '0.2.14'
  s.platform           = Gem::Platform::RUBY
  s.authors            = ['Nilton Vasques', 'Victor Cordeiro', 'Beatriz Fagundes']
  s.email              = ['nilton.vasques@gmail.com', 'victorcorcos@gmail.com', 'beatrizsfslima@gmail.com']
  s.description        = 'Parsec'
  s.homepage           = 'https://github.com/niltonvasques/parsec'
  s.summary            = 'A gem to evaluate math equations using a lighter and faster version of the muparserx C++ library'
  s.files              = ['lib/parsec.rb', 'lib/string_to_boolean_refinements.rb']
  s.test_files         = ['test/test_parsec.rb']
  s.require_paths      = ['lib', 'ext/libnativemath', '.']
  s.license            = 'mit'

  s.add_development_dependency 'minitest', '~> 5.10'
  s.add_development_dependency 'rake', '~> 12.1'
  s.extensions = %w[ext/libnativemath/extconf.rb]
end
