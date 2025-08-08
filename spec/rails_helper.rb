# typed: false
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require "bundler/setup"
require "rails"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

# Create a minimal Rails application for testing
module En14960AssessmentsTest
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
    config.eager_load = false
    config.secret_key_base = "test-secret-key-base"

    # Set the root to the gem directory to avoid loading parent app config
    config.root = Pathname.new(__dir__).parent

    # Skip active record railtie to avoid database.yml requirement
    config.active_record.migration_error = :page_load

    # Minimal middleware stack
    config.middleware.delete ActionDispatch::Cookies
    config.middleware.delete ActionDispatch::Session::CookieStore
    config.middleware.delete ActionDispatch::Flash

    # Add routes for minimal functionality
    routes.append do
      root to: proc { [200, {}, ["OK"]] }
    end
  end
end

# Initialize the Rails application
Rails.application.initialize!

# Load the gem after Rails is initialized
require "en14960_assessments"

# Now require rspec-rails after Rails is initialized
require "rspec/rails"
# Don't require factory_bot_rails as it auto-loads factories
require "factory_bot"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# Create schema_migrations table if needed
begin
  ActiveRecord::Base.connection.create_table :schema_migrations do |t|
    t.string :version, null: false
  end
rescue
  nil
end

# Define ApplicationRecord before loading anything else
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

# Load and run migrations manually
migration_path = File.expand_path("../../db/migrate", __FILE__)
Dir[File.join(migration_path, "*.rb")].sort.each do |file|
  require file
  basename = File.basename(file, ".rb")
  class_name = basename.gsub(/^\d+_/, "").camelize
  class_name.constantize.new.change
end

# Load test models first, then other support files
require_relative "support/models/test_models"
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |f|
  next if f.include?("test_models.rb")
  require f
end

# Configure FactoryBot
# Don't use the default factory loading which might pick up parent app factories
FactoryBot.definition_file_paths = []
FactoryBot.find_definitions

# Now load only our gem's factories manually
Dir[File.expand_path("../factories/*.rb", __FILE__)].each do |factory_file|
  require factory_file
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # Clean database between tests
  config.before(:each) do
    ActiveRecord::Base.connection.tables.each do |table|
      next if table == "schema_migrations" || table == "ar_internal_metadata"
      ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    end
  end
end
