# typed: false
# frozen_string_literal: true

# Define ApplicationRecord for the assessment models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

# Stub modules for testing
module FormConfigurable
end

module ValidationConfigurable
end

# Minimal model classes for testing
class User < ActiveRecord::Base
  self.primary_key = :id
end

class Unit < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user, optional: true
end

class InspectorCompany < ActiveRecord::Base
  self.primary_key = :id
end

class Inspection < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :user, optional: true
  belongs_to :unit, optional: true
  belongs_to :inspector_company, optional: true

  # Define the PASS_FAIL_NA constant needed by assessment models
  PASS_FAIL_NA = {fail: 0, pass: 1, na: 2}.freeze

  # Define assessment associations
  ASSESSMENT_TYPES = {
    user_height_assessment: En14960Assessments::UserHeightAssessment,
    slide_assessment: En14960Assessments::SlideAssessment,
    structure_assessment: En14960Assessments::StructureAssessment,
    anchorage_assessment: En14960Assessments::AnchorageAssessment,
    materials_assessment: En14960Assessments::MaterialsAssessment,
    enclosed_assessment: En14960Assessments::EnclosedAssessment,
    fan_assessment: En14960Assessments::FanAssessment
  }.freeze

  ASSESSMENT_TYPES.each do |assessment_name, assessment_class|
    has_one assessment_name,
      class_name: assessment_class.name,
      dependent: :destroy

    # Auto-create assessment if missing
    define_method(assessment_name) do
      super() || assessment_class.find_or_create_by!(inspection: self)
    end
  end
end
