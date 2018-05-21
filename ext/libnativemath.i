/* ext/librubyandcpp.i */
%module libnativemath
%include "std_string.i"
%{
  #include "libnativemath.h"
%}

extern std::string native_eval(std::string input);

/* ext/libpayroll.i */
%typemap(in, numinputs=0) (std::string *value, char *value_type) {
  $1 = new std::string("");
  $2 = (char *)malloc(2 * sizeof(char));
};
%typemap(argout) (std::string *value, char *value_type) {
  if(result == 0) {
    $result = rb_hash_new();
    rb_hash_aset($result, rb_str_new2("value"), rb_str_new2(*$1));
    rb_hash_aset($result, rb_str_new2("type"), rb_str_new2($2));
  } else {
    $result = Qfalse;
  }
}
/* ext/libpayroll.i */
%typemap(freearg) (std::string *value, char *value_type) {
  free($1);
  free($2);
}
extern int calculate_income_tax(std::string input, std::string *value, char *value_type);
