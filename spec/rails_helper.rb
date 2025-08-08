# typed: false
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require "rails"
require "active_record"
require "en14960_assessments"

# Set the root to the gem directory to avoid loading parent app config
Rails.application.config.root = Pathname.new(__dir__).parent if Rails.application

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)
