/* ext/libnativemath.cpp */
#include <iostream>
#include <cmath>
#include "mpParser.h"
#include "mpDefines.h"
#include "libnativemath.h"

using namespace std;
using namespace mup;

Value Calc(string input) {
  cout << "#####################" << endl;
  cout << input << endl;
  cout << "#####################" << endl;
  ParserX  parser(pckALL_NON_COMPLEX);

  Value ans;
  parser.DefineVar(_T("ans"), Variable(&ans));

    try
    {
      parser.SetExpr(input);

      // The returned result is of type Value, value is a Variant like
      // type that can be either a boolean, an integer or a floating point value
      ans = parser.Eval();

      return ans;

      //{
      //  // Value supports C++ streaming like this:
      //  console() << _T("Result (type: '") << ans.GetType() <<  _T("'):\n");
      //  console() << _T("ans = ") << ans << _T("\n");
      //}

    }
    catch(ParserError &e)
    {
      if (e.GetPos()!=-1)
      {
        string_type sMarker;
        sMarker.insert(0, input.size() + e.GetPos(), ' ');
        cout << sMarker;
      }

      cout << e.GetMsg() << _T(" (Errc: ") << std::dec << e.GetCode() << _T(")") << _T("\n\n");
    } // try / catch
//  } // for (;;)
    return ans;
} // Calc

std::string native_eval(std::string input)
{
  return Calc(input).AsString();
}
