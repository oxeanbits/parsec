/* ext/librubyandcpp.i */
%module libnativemath
%include "std_string.i"
%{
  #include "libnativemath.h"
%}

extern std::string native_direct_eval(std::string input);

%typemap(in, numinputs=0) (char *value, char *value_type) {
  $1 = (char *)malloc(100 * sizeof(char));
  $2 = (char *)malloc(2 * sizeof(char));
};
%typemap(argout) (char *value, char *value_type) {
  if(result == 0) {
    $result = rb_hash_new();
    rb_hash_aset($result, rb_str_new2("value"), rb_str_new2($1));
    switch (*$2) {
      case 'i': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("int")); break;
      case 'f': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("float")); break;
      case 'm': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("matrix")); break;
      case 's': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("string")); break;
      case 'b': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("boolean")); break;
    }
  } else {
    $result = Qfalse;
  }
}

%typemap(freearg) (char *value, char *value_type) {
  free($1);
  free($2);
}
extern int native_eval(std::string input, char *value, char *value_type);
