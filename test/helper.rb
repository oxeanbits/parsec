require 'rubygems'
require 'bundler/setup'
require 'simplecov'

SimpleCov.start 'rails' do
  add_filter "/test/"
end

require 'shields_badge'

SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge

require 'minitest/autorun'
require 'mocha/setup'
