# frozen_string_literal: true

require 'constants/roles/in_organization'

class CreateRoleInOrganizations < ActiveRecord::Migration[6.1]
  DEFAULT_ROLE = Constants::Roles::InOrganization::DEFAULT
  def change
    create_table :role_in_organizations do |t|
      t.references :organization_membership, null: false, foreign_key: true
      t.references :added_by, null: true, foreign_key: { to_table: :users }

      t.string :name, null: false, default: DEFAULT_ROLE

      t.index %i[name organization_membership_id], unique: true,
                                                   name: 'unique_organization_membership_index'
      t.timestamps
    end
  end
end
