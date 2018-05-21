/* ext/librubyandcpp.i */
%module libnativemath
%{
  #include "libnativemath.h"
%}

extern double calculate_hypot(const double a, const double b);
