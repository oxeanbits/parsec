require 'bundler/gem_tasks'
require 'rake/clean'
require 'rake/testtask'

task default: :spec

CLEAN.include('ext/**/*{.o,.log,.so,.bundle}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/*{.so,.bundle}')

desc 'Build the libnativemath C extension'

task :build_ext do
  Dir.chdir('ext/libnativemath/') do
    ruby 'extconf.rb'
    sh 'make'
  end
end

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/test_*.rb'
  test.verbose = true
end
