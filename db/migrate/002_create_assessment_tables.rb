# typed: false
# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
class CreateAssessmentTables < ActiveRecord::Migration[7.0]
  def change
    create_anchorage_assessments
    create_enclosed_assessments
    create_fan_assessments
    create_materials_assessments
    create_slide_assessments
    create_structure_assessments
    create_user_height_assessments
  end

  private

  def create_anchorage_assessments
    return if table_exists?(:anchorage_assessments)

    create_table :anchorage_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.integer :num_low_anchors
      t.integer :num_high_anchors
      t.boolean :anchor_accessories_pass
      t.boolean :anchor_degree_pass
      t.boolean :anchor_type_pass
      t.boolean :pull_strength_pass
      t.text :anchor_accessories_comment
      t.text :anchor_degree_comment
      t.text :anchor_type_comment
      t.text :pull_strength_comment
      t.text :num_low_anchors_comment
      t.text :num_high_anchors_comment
      t.boolean :num_low_anchors_pass
      t.boolean :num_high_anchors_pass
      t.timestamps

      t.index :inspection_id, unique: true,
        name: "anchorage_assessments_new_pkey"
    end

    add_foreign_key :anchorage_assessments, :inspections
  end

  def create_enclosed_assessments
    return if table_exists?(:enclosed_assessments)

    create_table :enclosed_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.integer :exit_number
      t.boolean :exit_number_pass
      t.text :exit_number_comment
      t.boolean :exit_sign_always_visible_pass
      t.text :exit_sign_always_visible_comment
      t.timestamps

      t.index :inspection_id, unique: true,
        name: "enclosed_assessments_new_pkey"
    end

    add_foreign_key :enclosed_assessments, :inspections
  end

  def create_fan_assessments
    return if table_exists?(:fan_assessments)

    create_table :fan_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.text :fan_size_type
      t.integer :blower_flap_pass, limit: 1
      t.text :blower_flap_comment
      t.boolean :blower_finger_pass
      t.text :blower_finger_comment
      t.integer :pat_pass, limit: 1
      t.text :pat_comment
      t.boolean :blower_visual_pass
      t.text :blower_visual_comment
      t.string :blower_serial
      t.timestamps
      t.integer :number_of_blowers
      t.decimal :blower_tube_length, precision: 8, scale: 2
      t.boolean :blower_tube_length_pass
      t.text :blower_tube_length_comment

      t.index :inspection_id, unique: true,
        name: "fan_assessments_new_pkey"
    end

    add_foreign_key :fan_assessments, :inspections
  end

  def create_materials_assessments
    return if table_exists?(:materials_assessments)

    create_table :materials_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.integer :ropes
      t.integer :ropes_pass, limit: 1
      t.integer :retention_netting_pass, limit: 1
      t.integer :zips_pass, limit: 1
      t.integer :windows_pass, limit: 1
      t.integer :artwork_pass, limit: 1
      t.boolean :thread_pass
      t.boolean :fabric_strength_pass
      t.boolean :fire_retardant_pass
      t.text :ropes_comment
      t.text :retention_netting_comment
      t.text :zips_comment
      t.text :windows_comment
      t.text :artwork_comment
      t.text :thread_comment
      t.text :fabric_strength_comment
      t.text :fire_retardant_comment
      t.timestamps

      t.index :inspection_id, unique: true,
        name: "materials_assessments_new_pkey"
    end

    add_foreign_key :materials_assessments, :inspections
  end

  def create_slide_assessments
    return if table_exists?(:slide_assessments)

    create_table :slide_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.decimal :slide_platform_height, precision: 8, scale: 2
      t.decimal :slide_wall_height, precision: 8, scale: 2
      t.decimal :runout, precision: 8, scale: 2
      t.decimal :slide_first_metre_height, precision: 8, scale: 2
      t.decimal :slide_beyond_first_metre_height, precision: 8,
        scale: 2
      t.integer :clamber_netting_pass, limit: 1
      t.boolean :runout_pass
      t.boolean :slip_sheet_pass
      t.boolean :slide_permanent_roof
      t.text :slide_platform_height_comment
      t.text :slide_wall_height_comment
      t.text :slide_first_metre_height_comment
      t.text :slide_beyond_first_metre_height_comment
      t.text :slide_permanent_roof_comment
      t.text :clamber_netting_comment
      t.text :runout_comment
      t.text :slip_sheet_comment
      t.timestamps

      t.index :inspection_id, unique: true,
        name: "slide_assessments_new_pkey"
    end

    add_foreign_key :slide_assessments, :inspections
  end

  def create_structure_assessments
    return if table_exists?(:structure_assessments)

    create_table :structure_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.boolean :seam_integrity_pass
      t.boolean :air_loss_pass
      t.boolean :straight_walls_pass
      t.boolean :sharp_edges_pass
      t.boolean :unit_stable_pass
      t.decimal :unit_pressure, precision: 8, scale: 2
      t.integer :critical_fall_off_height
      t.integer :trough_depth
      t.boolean :stitch_length_pass
      t.boolean :evacuation_time_pass
      t.boolean :critical_fall_off_height_pass
      t.boolean :unit_pressure_pass
      t.boolean :trough_pass
      t.boolean :entrapment_pass
      t.boolean :markings_pass
      t.boolean :grounding_pass
      t.text :seam_integrity_comment
      t.text :stitch_length_comment
      t.text :air_loss_comment
      t.text :straight_walls_comment
      t.text :sharp_edges_comment
      t.text :unit_stable_comment
      t.text :evacuation_time_comment
      t.text :critical_fall_off_height_comment
      t.text :unit_pressure_comment
      t.text :trough_comment
      t.text :entrapment_comment
      t.text :markings_comment
      t.text :grounding_comment
      t.boolean :step_height_max_pass
      t.text :step_height_max_comment
      t.integer :platform_height
      t.boolean :platform_height_pass
      t.text :platform_height_comment
      t.text :platform_gap_comment
      t.boolean :platform_gap_pass
      t.integer :containing_wall_height
      t.boolean :containing_wall_height_pass
      t.text :containing_wall_height_comment
      t.integer :step_ramp_angle
      t.text :step_ramp_angle_comment
      t.boolean :step_ramp_angle_pass
      t.integer :step_size
      t.text :step_size_comment
      t.boolean :step_ramp_size_pass
      t.text :step_ramp_size_comment
      t.timestamps

      t.index :inspection_id, unique: true,
        name: "structure_assessments_new_pkey"
    end

    add_foreign_key :structure_assessments, :inspections
  end

  def create_user_height_assessments
    return if table_exists?(:user_height_assessments)

    create_table :user_height_assessments, id: false do |t|
      t.string :inspection_id, limit: 12, null: false
      t.decimal :containing_wall_height, precision: 8, scale: 2
      t.text :containing_wall_height_comment
      t.decimal :play_area_length, precision: 8, scale: 2
      t.text :play_area_length_comment
      t.decimal :play_area_width, precision: 8, scale: 2
      t.text :play_area_width_comment
      t.decimal :negative_adjustment, precision: 8, scale: 2
      t.text :negative_adjustment_comment
      t.integer :users_at_1000mm
      t.integer :users_at_1200mm
      t.integer :users_at_1500mm
      t.integer :users_at_1800mm
      t.timestamps
      t.text :custom_user_height_comment

      t.index :inspection_id, unique: true,
        name: "user_height_assessments_new_pkey"
    end

    add_foreign_key :user_height_assessments, :inspections
  end
end
# rubocop:enable Metrics/MethodLength
