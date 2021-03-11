require 'minitest/autorun'
require 'parsec'
require 'date'

# This class test all possible equations for this gem
class TestParsec < Minitest::Test
  def test_defined
    assert defined?(Parsec::Parsec)
    assert defined?(Parsec::Parsec::VERSION)
  end

  def test_simple_math_equations
    parser = Parsec::Parsec
    assert_equal(10, parser.eval_equation('(5 + 1) + (6 - 2)'))
    assert_equal(16, parser.eval_equation('4 + 4 * 3'))
    assert_equal(2, parser.eval_equation('10.5 / 5.25'))
    assert_equal(5, parser.eval_equation('abs(-5)'))
    assert_equal(1, parser.eval_equation('log10(10)'))
    assert_equal(4, parser.eval_equation('round(4.4)'))
    assert_equal(729, parser.eval_equation('(3^3)^2'))
    assert_equal(196_83, parser.eval_equation('3^(3^(2))'))
    assert_equal(362_880_0, parser.eval_equation('10!'))
  end

  def test_complex_math_equations
    parser = Parsec::Parsec
    assert_equal(6, parser.eval_equation('sqrt(16) + cbrt(8)'))
    assert_equal(4.30259, parser.eval_equation('log10(10) + ln(e) + log(10)'))
    assert_equal(2.0, parser.eval_equation('sin(1) + cos(0) + tan(0.15722)'))
    assert_equal(16, parser.eval_equation('max(1, 2) + min(3, 4) + sum(5, 6)'))
    assert_equal(9.6, parser.eval_equation('avg(9, 9.8, 10)'))
    assert_equal(8, parser.eval_equation('pow(2, 3)'))
    assert_equal(4.56, parser.eval_equation('round_decimal(4.559, 2)'))
  end

  def test_if_then_else_equations
    parser = Parsec::Parsec
    assert_equal('bigger', parser.eval_equation('4 > 2 ? "bigger" : "smaller"'))
    assert_equal(true, parser.eval_equation('2 == 2 ? true : false'))
    assert_equal(false, parser.eval_equation('2 != 2 ? true : false'))
    assert_equal('yes', parser.eval_equation('"this" == "this" ? "yes" : "no"'))
    assert_equal('yes', parser.eval_equation('"this" != "that" ? "yes" : "no"'))
  end

  def test_logic_manipulation
    parser = Parsec::Parsec
    assert_equal(false, parser.eval_equation('true and false'))
    assert_equal(true, parser.eval_equation('true or false'))
    assert_equal(false, parser.eval_equation('(3==3) and (3!=3)'))
    assert_equal(true, parser.eval_equation('exp(1) == e'))
  end

  def test_simple_string_manipulation
    parser = Parsec::Parsec
    assert_equal(11, parser.eval_equation('length("test string")'))
    assert_equal('TEST STRING', parser.eval_equation('toupper("test string")'))
    assert_equal('test string', parser.eval_equation('tolower("TEST STRING")'))
    assert_equal('Hello World', parser.eval_equation('concat("Hello ", "World")'))
    assert_equal(5, parser.eval_equation('str2number("5")'))
    assert_equal(5, parser.eval_equation('number("5")'))
    assert_equal('Hello', parser.eval_equation('left("Hello World", 5)'))
    assert_equal('World', parser.eval_equation('right("Hello World", 5)'))
    assert_equal('<a href="http://foo.bar">Title</a>', parser.eval_equation('link("Title", "http://foo.bar")'))
    assert_equal('<a href="#">Title</a>', parser.eval_equation('link("Title", "#")'))
    assert_equal('<a href="/test">Test title</a>', parser.eval_equation('link("Test title", "/test")'))
    assert_raises(SyntaxError) { parser.eval_equation_with_type('link()') }
    assert_raises(SyntaxError) { parser.eval_equation_with_type('link(1, 2, 3)') }
    assert_raises(SyntaxError) { parser.eval_equation_with_type('link(1, "2")') }
  end

  def test_complex_string_manipulation
    parser = Parsec::Parsec
    assert_equal('string with quote"', parser.eval_equation('"string with quote\""'))
    assert_equal('HELLO WORLD', parser.eval_equation('toupper(concat("hello ", "world"))'))
    assert_equal('test lowercase', parser.eval_equation('tolower("TEST LOWERCASE")'))
    assert_equal('Hello', parser.eval_equation('left("Hello World", 5)'))
    assert_equal('World', parser.eval_equation('right("Hello World", 5)'))
  end

  def test_general_equations
    parsec = Parsec::Parsec
    assert_equal(1, parsec.eval_equation('((0.09/1.0)+2.58)-1.67'))
    assert_equal(40.6853, parsec.eval_equation('10^log(3+2)'))
    assert_equal(1, parsec.eval_equation('log(e)'))
    assert_equal(2, parsec.eval_equation('2^5^0'))
    assert_equal('yes', parsec.eval_equation('5 > 3 ? "yes" : "no"'))
    assert_equal(1, parsec.eval_equation('"this" == "this" ? 1 : 0'))
    assert_equal(9.9812, parsec.eval_equation('sqrt(9)+cbrt(8)+abs(-4.9812)'))
    assert_equal(3_628_680, parsec.send(:eval_equation, '10! - 5! * -(-1)'))
    assert_equal(true, parsec.eval_equation('sum(1,2,3,4,5) == max(14.99, 15)'))
    assert_equal(0.55, parsec.eval_equation('avg(1,2,3,4,5,6,7,8,9,10) / 10'))
    assert_equal(5, parsec.eval_equation('round(4.62)'))
    assert_equal(4.63, parsec.eval_equation('round_decimal(4.625, 2)'))
    assert_equal('5', parsec.eval_equation('string(5)'))
    assert_equal('5.123', parsec.eval_equation('string(5.123)'))
  end

  def test_newlines_remotion
    parsec = Parsec::Parsec
    assert_equal(true, parsec.validate_syntax("4 + \n 2"))
    assert_equal(true, parsec.validate_syntax("\n4\n+ \n 2\n"))
  end

  def test_equation_with_bad_syntax
    parsec = Parsec::Parsec
    assert_raises(SyntaxError) { parsec.eval_equation('concat(1, 2)') }
    assert_raises(SyntaxError) { parsec.eval_equation('4 > 2 ? "smaller"') }
  end

  def test_validate_syntax
    parsec = Parsec::Parsec
    refute_equal(true, parsec.validate_syntax('((0.09/1.0)+2.58)-1.6+'))
    assert_equal('Missing parenthesis.', parsec.validate_syntax('(0.09/1.0'))
  end

  def test_validate_syntax!
    parsec = Parsec::Parsec
    assert_raises(SyntaxError) { parsec.validate_syntax!('((0.09/1.0)+2.58)-1.6+') }
    assert_raises(SyntaxError) { parsec.validate_syntax!('(0.09/1.0') }
  end

  def test_date_functions
    parsec = Parsec::Parsec
    assert_equal(Date.today, Date.parse(parsec.eval_equation('current_date()')))
    assert_match(/^\d{4}-\d{2}-\d{2}$/, parsec.eval_equation('current_date()'))
    assert_equal(364, parsec.eval_equation('daysdiff("2018-01-01", "2018-12-31")'))
    assert_equal(365, parsec.eval_equation('daysdiff("2016-01-01", "2016-12-31")'))
    assert_equal(365, parsec.eval_equation('daysdiff("2000-01-01", "2000-12-31")'))
    assert_equal(364, parsec.eval_equation('daysdiff("2100-01-01", "2100-12-31")'))
    assert_equal(1, parsec.eval_equation('daysdiff("2018-01-01", "2017-12-31")'))
  end

  def test_datetime_functions
    parsec = Parsec::Parsec
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-01-01", "2018-01-02")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-01-01", "2018-1-02")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-1-01", "2018-01-02")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-1-01", "2018-1-02")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-01-01", "2018-01-2")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-01-1", "2018-01-02")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-01-1", "2018-01-2")'))
    assert_equal(24, parsec.eval_equation('hoursdiff("2018-1-1", "2018-1-2")'))
    assert_equal(288, parsec.eval_equation('hoursdiff("2019-02-01", "2019-02-13")'))
    assert_equal(4, parsec.eval_equation('hoursdiff("2019-02-01T08:00", "2019-02-01T12:00")'))
    assert_equal(28, parsec.eval_equation('hoursdiff("2019-02-01T08:00", "2019-02-02T12:00")'))
    assert_equal(3.67, parsec.eval_equation('hoursdiff("2019-02-01T08:20", "2019-02-01T12:00")'))
    assert_equal(0, parsec.eval_equation('hoursdiff(current_date(), current_date())'))
    assert_operator(parsec.eval_equation('hoursdiff(current_date(), "2000-01-01")'), :<, 0)
    assert_equal(0, parsec.eval_equation('hoursdiff("2018-01-01", "2018-01-01")'))
    assert_equal(-20, parsec.eval_equation('hoursdiff("2018-01-02T08:00", "2018-01-01T12:00")'))
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff("2018-01-01", "INVALID2")') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff("INVALID1", "2018-01-01")') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff("INVALID1", "INVALID2")') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff(2, 3)') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff("2018-01-01", "2018-01-01T12:00")') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff("2018-01-01T12:00", "2018-01-01")') }
    assert_raises(SyntaxError) { parsec.eval_equation('hoursdiff(current_date(), "2010-01-01T08:30")') }
  end

  def test_add_days
    parsec = Parsec::Parsec

    # With Dates
    assert_equal('2019-01-01', parsec.eval_equation('add_days("2019-01-01", 0)'))
    assert_equal('2019-01-02', parsec.eval_equation('add_days("2019-01-01", 1)'))
    assert_equal('2018-12-31', parsec.eval_equation('add_days("2019-01-01", -1)'))
    assert_equal('2019-01-04', parsec.eval_equation('add_days("2019-01-01", 3)'))

    # # With DateTimes
    assert_equal('2019-01-01T08:30', parsec.eval_equation('add_days("2019-01-01T08:30", 0)'))
    assert_equal('2019-02-01T12:30', parsec.eval_equation('add_days("2019-01-01T12:30", 31)'))
    assert_equal('2019-01-02T15:30', parsec.eval_equation('add_days("2019-01-01T15:30", 1)'))
    assert_equal('2019-01-02T20:30', parsec.eval_equation('add_days("2019-01-01T08:30", 1.5)'))
    assert_equal('2018-12-31T08:30', parsec.eval_equation('add_days("2019-01-01T08:30", -1)'))

    # With Errors
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('add_days("2019-01-33", 0)') }
    # assert_raises(SyntaxError) { parsec.eval_equation_with_type('add_days("2019-01-01T08:61", 0)') } # Dont work on Linux
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('add_days()') }
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('add_days(1, 2, 3)') }
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('add_days(1, 2)') }
  end

  def test_mask
    parsec = Parsec::Parsec
    assert_equal('123-456', parsec.eval_equation('mask("000-000", 123456)'))
    assert_equal('00014', parsec.eval_equation('mask("00000", 14)'))
    assert_equal('000 14', parsec.eval_equation('mask("000 00", 14)'))
    assert_equal('#123', parsec.eval_equation('concat("#", mask("000", 123))'))
    assert_equal('12345', parsec.eval_equation('mask("0000", 12345)'))
    assert_equal('123 45', parsec.eval_equation('mask("00 00", 12345)'))
    assert_equal('3-5591-1801', parsec.eval_equation('mask("0-0000-0000", 355911801)'))
    assert_equal('35-5591-1801', parsec.eval_equation('mask("00-0000-0000", 3555911801)'))
    assert_equal('12-1234-1234-1234', parsec.eval_equation('mask("00-0000-0000-0000", 12123412341234)'))
    assert_equal('1-1234-1234-1234-1234', parsec.eval_equation('mask("0-0000-0000-0000-0000", 11234123412341234)'))
  end

  def test_default_value
    parsec = Parsec::Parsec

    # Success Scenarios
    assert_equal(10, parsec.eval_equation('default_value(10, 1)'))
    assert_equal(1, parsec.eval_equation('default_value(NULL, 1)'))
    assert_equal(10.4, parsec.eval_equation('default_value(10.4, 1.01)'))
    assert_equal(1.01, parsec.eval_equation('default_value(NULL, 1.01)'))
    assert_equal('filled', parsec.eval_equation('default_value("filled", "default")'))
    assert_equal('default', parsec.eval_equation('default_value(NULL, "default")'))
    assert_equal(false, parsec.eval_equation('default_value(false, true)'))
    assert_equal(true, parsec.eval_equation('default_value(NULL, true)'))

    # Mixing number types
    assert_equal(1, parsec.eval_equation('default_value(1, 4.5)'))
    assert_equal(1, parsec.eval_equation('default_value(1, 10)'))
    assert_equal(1, parsec.eval_equation('default_value(1, 10.0)'))
    assert_equal(1, parsec.eval_equation('default_value(1.0, 10)'))
    assert_equal(1, parsec.eval_equation('default_value(1.0, 10.0)'))
    assert_equal(1.5, parsec.eval_equation('default_value(1.5, 10)'))
    assert_equal(1.5, parsec.eval_equation('default_value(1.5, 10.0)'))
    assert_equal(1.5, parsec.eval_equation('default_value(1.5, 10.5)'))

    # Error Scenarios
    assert_raises(SyntaxError) { parsec.eval_equation('default_value(4.5, "string")') }
    assert_raises(SyntaxError) { parsec.eval_equation('default_value("string", true)') }
    assert_raises(SyntaxError) { parsec.eval_equation('default_value(true, 1)') }
  end

  def test_eval_equation_with_type
    parsec = Parsec::Parsec
    assert_equal({ value: 10, type: :int }, parsec.eval_equation_with_type('(5 + 1) + (6 - 2)'))
    assert_equal({ value: 362_880_0, type: :int }, parsec.eval_equation_with_type('10!'))
    equation_date = 'daysdiff("2018-01-01", "2017-12-31")'
    assert_equal({ value: 1, type: :int }, parsec.eval_equation_with_type(equation_date))
    assert_equal({ value: 40.6853, type: :float }, parsec.eval_equation_with_type('10^log(3+2)'))
    assert_equal({ value: 5.1, type: :float }, parsec.eval_equation_with_type('number("5.1")'))
    equation_if = '4 > 2 ? "bigger" : "smaller"'
    assert_equal({ value: 'bigger', type: :string }, parsec.eval_equation_with_type(equation_if))
    assert_equal({ value: '5.123', type: :string }, parsec.eval_equation_with_type('string(5.123)'))
    equation_boolean = '2 == 2 ? true : false'
    assert_equal({ value: true, type: :boolean }, parsec.eval_equation_with_type(equation_boolean))
    equation_boolean = '(3==3) and (3!=3)'
    assert_equal({ value: false, type: :boolean }, parsec.eval_equation_with_type(equation_boolean))
    assert_equal({ value: 'Infinity', type: :float }, parsec.eval_equation_with_type('4 / 0'))
    assert_equal({ value: 'nan', type: :float }, parsec.eval_equation_with_type('0 / 0'))
    # invalid equations raises an error
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('concat(1, 2)') }
    assert_raises(SyntaxError) { parsec.eval_equation_with_type('4 > 2 ? "smaller"') }
  end
end
