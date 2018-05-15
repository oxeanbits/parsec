require 'minitest/autorun'
require 'parsec'

class TestParsec < Minitest::Test
  def test_defined
    assert defined?(EquationsParser::Parsec)
    assert defined?(EquationsParser::Parsec::VERSION)
  end

  def test_eval_correct_equations
    parsec = EquationsParser::Parsec.new
    assert_equal(1, parsec.send(:eval_equation, '((0.09/1.0)+2.58)-1.67'))
    assert_equal(40.6853365119738, parsec.send(:eval_equation, '10^log(3+2)'))
    assert_equal(1, parsec.send(:eval_equation, 'log(e)'))
    assert_equal(2, parsec.send(:eval_equation, '2^5^0'))
  end

  def test_string_manipulation
    parsec = EquationsParser::Parsec.new
    assert_equal('HELLO WORLD', parsec.send(:eval_equation, 'toupper(concat("hello ", "world"))'))
  end
end
