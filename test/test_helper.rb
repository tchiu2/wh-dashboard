ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

# Load seeds
Rails.application.load_seed

module LogInHelper
  def log_in_as(email:, password:)
    post login_path, params: { login: { email: email, password: password } }
  end
end

class ActionDispatch::IntegrationTest
  include LogInHelper
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
end
