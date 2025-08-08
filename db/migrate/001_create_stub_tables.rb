# typed: false
# frozen_string_literal: true

class CreateStubTables < ActiveRecord::Migration[7.0]
  def change
    # Create minimal stub tables for testing the gem independently
    # These tables will be skipped in the main app where they already exist
    create_users_table
    create_units_table
    create_inspector_companies_table
    create_inspections_table
  end

  private

  def create_users_table
    return if table_exists?(:users)

    create_table :users, id: string_id_type do |t|
      t.timestamps
    end
  end

  def create_units_table
    return if table_exists?(:units)

    create_table :units, id: string_id_type do |t|
      t.string :user_id, limit: 12
      t.timestamps
    end
  end

  def create_inspector_companies_table
    return if table_exists?(:inspector_companies)

    create_table :inspector_companies, id: string_id_type do |t|
      t.timestamps
    end
  end

  def create_inspections_table
    return if table_exists?(:inspections)

    create_table :inspections, id: string_id_type do |t|
      t.string :user_id, limit: 12, null: false
      t.string :unit_id, limit: 12
      t.string :inspector_company_id, limit: 12
      t.timestamps
    end
  end

  def string_id_type
    {type: :string, limit: 12}
  end
end
