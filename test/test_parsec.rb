require 'minitest/autorun'
require 'parsec'

class TestParsec < Minitest::Test
  def test_defined
    assert defined?(EquationsParser::Parsec)
    assert defined?(EquationsParser::Parsec::VERSION)
  end

  def test_eval_correct_equations
    parsec = EquationsParser::Parsec
    assert_equal(1, parsec.eval_equation('((0.09/1.0)+2.58)-1.67'))
    assert_equal(40.6853365119738, parsec.eval_equation('10^log(3+2)'))
    assert_equal(1, parsec.eval_equation('log(e)'))
    assert_equal(2, parsec.eval_equation('2^5^0'))
    assert_equal('yes, it is', parsec.eval_equation('5 > 3 ? "yes, it is" : "no, it isnt"'))
    assert_equal(1, parsec.eval_equation('"this" == "this" ? 1 : 0'))
    assert_equal(9.9811111, parsec.eval_equation('sqrt(9) + cbrt(8) + abs(-4.9811111)'))
    assert_equal(3628680, parsec.send(:eval_equation, '10! - 5! * -(-1)'))
    assert_equal(true, parsec.eval_equation('sum(1,2,3,4,5) == max(14.99, 15, 14.999999)'))
    assert_equal(0.55, parsec.eval_equation('avg(1,2,3,4,5,6,7,8,9,10) / 10'))
  end

  def test_string_manipulation
    parsec = EquationsParser::Parsec.new
    assert_equal('HELLO WORLD', parsec.eval_equation('toupper(concat("hello ", "world"))'))
    assert_equal('test lowercase', parsec.eval_equation('tolower("TEST LOWERCASE")'))
  end
end
