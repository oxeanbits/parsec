require 'minitest/autorun'
require 'parsec'

# This class test all possible equations for this gem
class TestParsec < Minitest::Test
  def test_defined
    assert defined?(Parsec::Parsec)
    assert defined?(Parsec::Parsec::VERSION)
  end

  def test_eval_correct_equations
    parsec = Parsec::Parsec
    assert_equal(1, parsec.eval_equation('((0.09/1.0)+2.58)-1.67'))
    assert_equal(40.6853, parsec.eval_equation('10^log(3+2)'))
    assert_equal(1, parsec.eval_equation('log(e)'))
    assert_equal(2, parsec.eval_equation('2^5^0'))
    assert_equal('yes, it is', parsec.eval_equation('5 > 3 ? "yes, it is" : "no, it isnt"'))
    assert_equal(1, parsec.eval_equation('"this" == "this" ? 1 : 0'))
    assert_equal(9.98111, parsec.eval_equation('sqrt(9) + cbrt(8) + abs(-4.9811111)'))
    assert_equal(3_628_680, parsec.send(:eval_equation, '10! - 5! * -(-1)'))
    assert_equal(true, parsec.eval_equation('sum(1,2,3,4,5) == max(14.99, 15, 14.999999)'))
    assert_equal(0.55, parsec.eval_equation('avg(1,2,3,4,5,6,7,8,9,10) / 10'))
    assert_equal(5, parsec.eval_equation('round(4.62)'))
    assert_equal(4.63, parsec.eval_equation('round_decimal(4.625, 2)'))
  end

  def test_string_manipulation
    parsec = Parsec::Parsec
    assert_equal('HELLO WORLD', parsec.eval_equation('toupper(concat("hello ", "world"))'))
    assert_equal('test lowercase', parsec.eval_equation('tolower("TEST LOWERCASE")'))
    assert_equal('Hello', parsec.eval_equation('left("Hello World", 5)'))
    assert_equal('World', parsec.eval_equation('right("Hello World", 5)'))
  end
end
