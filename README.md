# parsec

A parser for Math equations using a lighter and faster version of muparserx C++ library

## Usage

> Add to your `Gemfile`

```ruby
gem 'parsec'
```

* Use Ruby version 2.5.1

> Add to the top of your <filename> file

```ruby
require 'parsec'
```

> You can then eval equations in your code

```ruby
parser = EquationsParser::Parsec.new
parser.eval_equation('5 + 1')
parser.eval_equation('(3 + 3) * (5 * 2)')
```

> You can also validate the formula syntax

```ruby
parser = EquationsParser::Parsec.new
parser.validate_syntax('3>=2 ? 1 : 0') # correct syntax, returns true
```

```ruby
parser = EquationsParser::Parsec.new
parser.validate_syntax('3>=2 ? 1') # bad syntax, returns StandarError with the message 'Wrong formula syntax'
```

> Here are examples of equations which are accepted by the parser
...

> The following Math functions can be used

* Standard functions abs, sin, cos, tan, sinh, cosh, tanh, ln, log, log10, exp, sqrt
* Unlimited number of arguments: min, max, sum
* String functions: str2number, length, toupper
* Complex functions: real, imag, conj, arg, norm
* Array functions: sizeof, eye, ones, zeros
