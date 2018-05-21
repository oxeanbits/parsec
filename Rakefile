require "bundler/gem_tasks"
require 'rake/clean'
require 'rake/testtask'

task :default => :spec

CLEAN.include('ext/**/*{.o,.log,.so,.bundle}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/*{.so,.bundle}')

desc 'Build the libnativemath C extension'
task :build_ext do
  Dir.chdir("ext/equations-parser/") do
    sh "cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release"
    sh "make"
  end

  Dir.chdir("ext/") do
    sh "swig -c++ -ruby libnativemath.i"
    ruby "extconf.rb"
    sh "make"
  end

  %w[ext/libnativemath.so ext/libnativemath.bundle].each do |file|
    cp file, "lib/" if system("[ -e #{file} ]")
  end
end

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/test_*.rb'
  test.verbose = true
end
