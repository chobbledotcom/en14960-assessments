# == Schema Information
#
# Table name: enclosed_assessments
#
#  exit_number                      :integer
#  exit_number_comment              :text
#  exit_number_pass                 :boolean
#  exit_sign_always_visible_comment :text
#  exit_sign_always_visible_pass    :boolean
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  inspection_id                    :string(12)       not null, primary key
#
# Indexes
#
#  enclosed_assessments_new_pkey  (inspection_id) UNIQUE
#
# Foreign Keys
#
#  inspection_id  (inspection_id => inspections.id)
#

# typed: true
# frozen_string_literal: true

class En14960Assessments::EnclosedAssessment < ApplicationRecord
  extend T::Sig
  include AssessmentLogging
  include AssessmentCompletion
  include FormConfigurable
  include ValidationConfigurable

  self.primary_key = "inspection_id"
  self.table_name = "enclosed_assessments"

  belongs_to :inspection

  validates :inspection_id,
    uniqueness: true
end
