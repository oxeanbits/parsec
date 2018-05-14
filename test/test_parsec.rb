require 'minitest/autorun'
require 'parsec'

class TestParsec < Minitest::Test
  def eval_correct_equations
    assert_equal(10, eval('5*2'))
    assert_equal(25, eval('5^2'))
  end
end
