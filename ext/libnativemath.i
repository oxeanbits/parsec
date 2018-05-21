/* ext/librubyandcpp.i */
%module libnativemath
%include "std_string.i"
%{
  #include "libnativemath.h"
%}

extern std::string native_eval(std::string input);
