/* ext/libnativemath.cpp */
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

string_type native_direct_eval(string_type input) {
  Value ans = Calc(input);
  return ans.AsString();
}

int native_eval(string input, char *value, char *value_type) {
  Value ans = Calc(input);

  value_type[0] = ans.GetType();
  value_type[1] = '\0';

  strcpy(value, ans.AsString().c_str());
  return 0;
}
