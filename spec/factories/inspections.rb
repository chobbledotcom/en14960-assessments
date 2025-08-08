# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :inspection do
    id { SecureRandom.alphanumeric(12) }
    user_id { SecureRandom.alphanumeric(12) }
    unit_id { SecureRandom.alphanumeric(12) }
  end
end
