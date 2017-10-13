require 'rubygems'
require 'bundler/setup'
require 'simplecov'

SimpleCov.start do
  add_filter "/test/"
end

require 'shields_badge'

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::ShieldsBadge
])

require 'minitest/autorun'
require 'mocha/setup'
