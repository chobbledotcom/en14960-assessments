# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { SecureRandom.alphanumeric(12) }
  end
end
