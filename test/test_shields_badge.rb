require 'helper'

class TestShieldsBadge < Minitest::Test
  def test_defined
    assert defined?(SimpleCov::Formatter::ShieldsBadge)
    assert defined?(SimpleCov::Formatter::ShieldsBadge::VERSION)
  end

  def stub_file(filename, coverage)
    lines = coverage.each_with_index.map do |cov, i|
      skipped = false
      if cov == :skipped
        skipped = true
        cov = 0
      end
      stub('SimpleCov::SourceFile::Line', skipped?: skipped, line_number: i+1, coverage: cov)
    end
    stub('SimpleCov::SourceFile', filename: filename, lines: lines)
  end

  def test_badge_svg_is_generated
    formatter = SimpleCov::Formatter::ShieldsBadge.new

    result = stub('SimpleCov::Result', covered_percent: 0)
    formatter.format(result)
    assert_equal(true, File.exist?('badge.svg'))
  end

  def test_right_badge_color
    formatter = SimpleCov::Formatter::ShieldsBadge.new
    assert_equal(:red, formatter.send(:coverage_color, 0))
    assert_equal(:red, formatter.send(:coverage_color, 20))
    assert_equal(:orange, formatter.send(:coverage_color, 21))
    assert_equal(:orange, formatter.send(:coverage_color, 40))
    assert_equal(:yellow, formatter.send(:coverage_color, 41))
    assert_equal(:yellow, formatter.send(:coverage_color, 60))
    assert_equal(:yellowgreen, formatter.send(:coverage_color, 61))
    assert_equal(:yellowgreen, formatter.send(:coverage_color, 80))
    assert_equal(:green, formatter.send(:coverage_color, 81))
    assert_equal(:green, formatter.send(:coverage_color, 90))
    assert_equal(:brightgreen, formatter.send(:coverage_color, 91))
    assert_equal(:brightgreen, formatter.send(:coverage_color, 100))
  end
end
