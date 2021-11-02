ENV['RAILS_ENV'] ||= 'test'

if ENV['CI'] == 'true'
  require 'coveralls'
  require 'simplecov'
  require 'simplecov-lcov'
  SimpleCov::Formatter::LcovFormatter.config do |config|
    config.report_with_single_file = true
    config.lcov_file_name = 'lcov.info'
  end

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                   SimpleCov::Formatter::LcovFormatter,
                                                                   Coveralls::SimpleCov::Formatter,
                                                                 ])

  SimpleCov.start
  Coveralls.wear!
end

require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  include AuthHelper
end
