# typed: false

require "rails_helper"

RSpec.describe "Assessment Models", type: :model do
  let(:user) { create(:user) }
  let(:unit) { create(:unit, user_id: user.id) }
  let(:inspection) { create(:inspection, user_id: user.id, unit_id: unit.id) }

  # Define assessment types for the gem
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
    describe assessment_class do
      let(:assessment) { inspection.send(assessment_name) }

      it_behaves_like "an assessment model"
    end
  end
end
