# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :unit do
    id { SecureRandom.alphanumeric(12) }
    user_id { SecureRandom.alphanumeric(12) }
  end
end
