/* ext/librubyandcpp.i */
%module libnativemath
%include "std_string.i"
%{
  #include "libnativemath.h"
%}

extern std::string native_direct_eval(std::string input);
extern std::string native_eval(std::string input);
