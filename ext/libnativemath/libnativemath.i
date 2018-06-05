/* ext/librubyandcpp.i */
%module libnativemath
%include "std_string.i"
%{
  #include "libnativemath.h"
%}

extern std::string native_direct_eval(std::string input);

%typemap(in, numinputs=0) (char *value, char *value_type) {
  char a[1000];
  char b;
  $1 = a;
  $2 = &b;
};
%typemap(argout) (char *value, char *value_type) {
  if(result == 0) {
    $result = rb_hash_new();
    rb_hash_aset($result, rb_str_new2("value"), rb_str_new2($1));
    switch (*$2) {
      case 'i': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("int")); break;
      case 'f': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("float")); break;
      case 's': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("string")); break;
      case 'b': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("boolean")); break;
      case 'c': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("complex")); break;
      case 'm': rb_hash_aset($result, rb_str_new2("type"), rb_str_new2("matrix")); break;
    }
  } else {
    $result = Qfalse;
  }
}

extern int native_eval(std::string input, char *value, char *value_type);
