# frozen_string_literal: true

class CreateOrganizationMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_memberships do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.references :created_by, null: true, foreign_key: { to_table: :users }

      t.index %i[user_id organization_id], unique: true

      t.timestamps
    end
  end
end
