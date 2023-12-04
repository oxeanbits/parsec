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

puts HEADER_DIRS
puts LIBDIR

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

GIT_REPOSITORY = 'https://github.com/oxeanbits/equations-parser.git'.freeze
COMMIT = '39d949b5f53d1650eb8f166db3883900f5ce55d4'.freeze

Dir.chdir(BASEDIR) do
  system('git init')
  system("git submodule add #{GIT_REPOSITORY} ext/equations-parser")
  system('git submodule update --init --recursive')

  Dir.chdir('ext/equations-parser/') do
    system("git checkout #{COMMIT}")
    system('cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release')
    system('make')
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

if RUBY_VERSION >= '3.2'
  create_makefile('../ext/libnativemath')
else
  create_makefile('ext/libnativemath/libnativemath')
end

Dir.chdir(BASEDIR) do
  Dir.chdir('ext/libnativemath/') do
    system('make')

    next if RUBY_PLATFORM.match? 'darwin'

    if RUBY_VERSION >= '3.2'
      FileUtils.cp('libnativemath.so', '../../lib/')
    end
  end
end
