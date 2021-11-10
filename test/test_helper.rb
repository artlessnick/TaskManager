require 'sidekiq/testing'

ENV['RAILS_ENV'] ||= 'test'

if ENV['CI'] == 'true'
  require 'coveralls'
  require 'simplecov'

  SimpleCov.start
  Coveralls.wear!
end
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  include AuthHelper
  Sidekiq::Testing.inline!

  def after_teardown
    super

    remove_uploaded_files
  end

  def remove_uploaded_files
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
