# Parsec

A parser for Math equations using a lighter, faster and more complete version of muparserx C++ library

## Usage

### Add to your `Gemfile`

```ruby
gem 'parsec'
```

* Use Ruby version 2.5.1

### Add to the top of your <filename> file

```ruby
require 'parsec'
```

### You can then eval equations in your code

```ruby
parser = Parsec::Parsec
parser.eval_equation('5 + 1')
parser.eval_equation('(3 + 3) * (5 * 2)')
```

### You can also validate the formula syntax

```ruby
parser = Parsec::Parsec
parser.validate_syntax('3>=2 ? 1 : 0') # correct syntax, returns true
```

```ruby
parser = Parsec::Parsec
parser.validate_syntax('3>=2 ? 1') # bad syntax, returns StandarError with the message 'Wrong formula syntax'
```

### Here are examples of equations which are accepted by the parser
```ruby
parser = Parsec::Parsec
# Simple Math equations
parser.eval_equation('(5 + 1) + (6 - 2)')
parser.eval_equation('4 + 4 * 3')
parser.eval_equation('10.5 / 5.25')
parser.eval_equation('abs(-5)')
parser.eval_equation('sqrt(16) + cbrt(8)')
parser.eval_equation('log10(10)')
parser.eval_equation('round(4.4)')
parser.eval_equation('(3^3)^2')
parser.eval_equation('3^(3^(2)')
parser.eval_equation('10!')
# Complex Math equations
parser.eval_equation('log10(10) + ln(e) + log(10)')
parser.eval_equation('sin(1) + cos(0) + tan(0.15722)')
parser.eval_equation('max(1, 2) + min(3, 4) + sum(5, 6)')
parser.eval_equation('avg(9, 9.8, 10)')
parser.eval_equation('pow(2, 3)')
parser.eval_equation('round_decimal(4.559, 2)')
# IF THEN ELSE equations
parser.eval_equation('4 > 2 ? "bigger" : "smaller"')
parser.eval_equation('2 == 2 ? true : false')
parser.eval_equation('2 != 2 ? true : false')
parser.eval_equation('"this" == "this" ? "yes" : "false"')
parser.eval_equation('"this" != "that" ? "yes" : "false"')
# Logic equations
parser.eval_equation('true and false')
parser.eval_equation('true or false')
parser.eval_equation('3==3 and 3!=3')
parser.eval_equation('exp(1) == e')
# String equations
parser.eval_equation('length("test string")')
parser.eval_equation('toupper("test string")')
parser.eval_equation('tolower("TEST STRING")')
parser.eval_equation('concat("Hello ", "World")')
parser.eval_equation('str2number("5")')
parser.eval_equation('left("Hello World", 5)')
parser.eval_equation('right("Hello World", 5)')
```

### The following functions can be used

* Math trigonometric functions: sin, cos, tan, sinh, cosh, tanh, asin, acos, atan, asinh, acosh, atanh
* Math logarithm functions: ln, log, log10
* Math standard functions: abs, sqrt, cbrt, pow, exp, round, round_decimal
* Math constants: e, pi
* Unlimited number of arguments: min, max, sum, avg
* String functions: concat, length, toupper, tolower, left, right, str2number
* Complex functions: real, imag, conj, arg, norm
* Array functions: sizeof, eye, ones, zeros
