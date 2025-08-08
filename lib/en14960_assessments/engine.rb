# typed: false
# frozen_string_literal: true

module En14960Assessments
  class Engine < ::Rails::Engine
    # Minimal engine for Rails 8 compatibility
    # Just provides Engine.root for file path lookups
    # Rails automatically loads app/ directories without configuration

    # Load locale files
    initializer "en14960_assessments.i18n" do |app|
      app.config.i18n.load_path += Dir[Engine.root.join("config", "locales", "**", "*.yml")]
    end
  end
end
