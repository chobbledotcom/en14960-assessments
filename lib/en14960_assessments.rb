# typed: false
# frozen_string_literal: true

require "sorbet-runtime"
require_relative "en14960_assessments/version"
require_relative "en14960_assessments/engine" if defined?(Rails)
require_relative "en14960_assessments/seed_data"

module En14960Assessments
  # Simple code container gem - models and views are loaded automatically by Rails
  # Minimal engine provides Engine.root for file lookups
end
