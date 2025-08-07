# typed: false

require "rails_helper"

RSpec.describe En14960Assessments::SeedData do
  describe ".slide_fields" do
    context "when passed: true" do
      it "generates runout values that meet safety requirements" do
        10.times do
          fields = described_class.slide_fields(passed: true)
          platform_height = fields[:slide_platform_height]
          runout = fields[:runout]

          required_runout = (0.866 + 0.20 * platform_height).round(3)
          meets_requirements = runout >= required_runout

          expect(meets_requirements).to be(true),
            "Expected runout #{runout}m to meet requirements for platform height #{platform_height}m (required: #{required_runout}m)"
        end
      end
    end

    context "when passed: false" do
      it "generates runout values that fail safety requirements" do
        10.times do
          fields = described_class.slide_fields(passed: false)
          platform_height = fields[:slide_platform_height]
          runout = fields[:runout]

          required_runout = (0.866 + 0.20 * platform_height).round(3)
          meets_requirements = runout >= required_runout

          expect(meets_requirements).to be(false),
            "Expected runout #{runout}m to fail requirements for platform height #{platform_height}m (required: #{required_runout}m)"
        end
      end
    end
  end
end
