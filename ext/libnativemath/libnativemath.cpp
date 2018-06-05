/* ext/libnativemath.cpp */
#include <string>
#include <iostream>
#include <cmath>
#include "mpParser.h"
#include "mpDefines.h"
#include "libnativemath.h"

using namespace std;
using namespace mup;

Value Calc(string input) {
  ParserX parser(pckALL_NON_COMPLEX);

  Value ans;
  parser.DefineVar(_T("ans"), Variable(&ans));

  try
  {
    parser.SetExpr(input);
    ans = parser.Eval();

    return ans;
  }
  catch(ParserError &e)
  {
    if (e.GetPos() != -1)
    {
      string_type error = "Error: ";
      error.append(e.GetMsg());
      return error;
    }
  }
  return ans;
}

string native_direct_eval(string input) {
  Value ans = Calc(input);
  return ans.AsString();
}

string native_eval(string input) {
  Value ans = Calc(input);
  stringstream_type ss;

  // Converting to json-like string
  ss << _T("{");
  ss << _T("\"value\": \"") << ans.AsString() << _T("\"");
  ss << _T(", ");
  ss << _T("\"type\": \"") << ans.GetType() << _T("\"");
  ss << _T("}");

  return ss.str();
}
