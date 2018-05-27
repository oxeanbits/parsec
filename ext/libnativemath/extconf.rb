# ext/extconf.rb
require 'mkmf'

# During gem install step, the path is different
BASEDIR = if File.exist?('parsec.gemspec')
            '.'
          else
            '../..'
          end

LIBDIR     = RbConfig::CONFIG['libdir']
INCLUDEDIR = RbConfig::CONFIG['includedir']
MUPARSER_HEADERS = "#{BASEDIR}/ext/equations-parser/parser".freeze
MUPARSER_LIB = "#{BASEDIR}/ext/equations-parser".freeze

HEADER_DIRS = [INCLUDEDIR, MUPARSER_HEADERS].freeze

puts '#'*90
puts 'LIBDIR: ' << LIBDIR.to_s
puts '#'*90
puts 'HEADER_DIRS: ' << HEADER_DIRS.to_s
puts '#'*90
puts 'MUPARSER_LIB: ' << HEADER_DIRS.to_s
puts '#'*90
puts '#'*20 << ' -- 1st pwd -- ' << '#'*20
puts Dir.pwd
puts '#'*90
puts '#'*20 << ' -- 1st ls -- ' << '#'*20
puts Dir.entries('.')
puts '#'*90

# setup constant that is equal to that of the file path that holds
# that static libraries that will need to be compiled against
LIB_DIRS = [LIBDIR, MUPARSER_LIB].freeze

# array of all libraries that the C extension should be compiled against
libs = ['-lmuparserx']

dir_config('libnativemath', HEADER_DIRS, LIB_DIRS)

abort 'swig is missing. Please install it.' unless find_executable('cmake')

abort 'swig is missing. Please install it.' unless find_executable('swig')

# iterate though the libs array, and append them
# to the $LOCAL_LIBS array used for the makefile creation
libs.each do |lib|
  $LOCAL_LIBS << "#{lib} "
end

Dir.chdir(BASEDIR) do
  system('git init')
  system('git submodule add https://github.com/niltonvasques/equations-parser.git ext/equations-parser')
  system('git submodule update --init --recursive')

  Dir.chdir('ext/equations-parser/') do
    puts '#'*90
    puts '#'*20 << ' -- 2nd pwd -- ' << '#'*20
    puts Dir.pwd
    puts '#'*90
    puts '#'*20 << ' -- 2nd ls -- ' << '#'*20
    puts Dir.entries('.')
    puts '#'*90

    # system('cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release')
    # system('make')

    puts '#'*90
    puts '#'*20 << ' -- cmake (C++ muparserx) -- ' << '#'*20
    puts `cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release`
    puts '#'*90
    puts '#'*20 << ' -- make (C++ muparserx) -- ' << '#'*20
    puts `make`
    puts '#'*90
  end

  Dir.chdir('ext/libnativemath/') do
    system('swig -c++ -ruby libnativemath.i')
  end
end

unless File.exist?("#{MUPARSER_HEADERS}/mpParser.h")
  abort 'mpParser.h header is missing.'
end

unless File.exist?("#{MUPARSER_LIB}/libmuparserx.a")
  abort 'libmuparserx.a is missing.'
end

create_makefile('ext/libnativemath/libnativemath')

Dir.chdir(BASEDIR) do
  Dir.chdir('ext/libnativemath/') do
    # system('make')

    puts '#'*90
    puts '#'*20 << ' -- make (Swig) -- ' << '#'*20
    puts `make`
    puts '#'*90
    abort 'ABORTED HERE'
    puts '#'*90
  end
end
