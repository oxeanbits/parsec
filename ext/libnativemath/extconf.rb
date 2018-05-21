# ext/extconf.rb
require 'mkmf'

# During gem install step, the path is different
if File.exists?("parsec.gemspec")
  BASEDIR = '.'
else
  BASEDIR = '../..'
end

LIBDIR     = RbConfig::CONFIG['libdir']
INCLUDEDIR = RbConfig::CONFIG['includedir']
MUPARSER_HEADERS = "#{BASEDIR}/ext/equations-parser/parser"
MUPARSER_LIB = "#{BASEDIR}/ext/equations-parser"

HEADER_DIRS = [INCLUDEDIR, MUPARSER_HEADERS]

puts HEADER_DIRS
puts LIBDIR

# setup constant that is equal to that of the file path that holds that static libraries that will need to be compiled against
LIB_DIRS = [LIBDIR, MUPARSER_LIB]

# array of all libraries that the C extension should be compiled against
libs = ['-lmuparserx']

dir_config('libnativemath', HEADER_DIRS, LIB_DIRS)

unless find_executable('swig')
  abort 'swig is missing. Please install it.'
end

unless File.exists?("#{MUPARSER_HEADERS}/mpParser.h")
  abort 'mpParser.h header is missing.'
end

# iterate though the libs array, and append them to the $LOCAL_LIBS array used for the makefile creation
libs.each do |lib|
  $LOCAL_LIBS << "#{lib} "
end

Dir.chdir(BASEDIR) do
  system("git submodule update --init --recursive")
  Dir.chdir("ext/equations-parser/") do
    system("cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release")
    system("make")
  end

  Dir.chdir("ext/libnativemath/") do
    system("swig -c++ -ruby libnativemath.i")
  end
end

unless File.exists?("#{MUPARSER_LIB}/libmuparserx.a")
  abort 'libmuparserx.a is missing.'
end

create_makefile('ext/libnativemath/libnativemath')
