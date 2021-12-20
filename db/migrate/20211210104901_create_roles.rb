# frozen_string_literal: true

require 'constants/roles/general'

class CreateRoles < ActiveRecord::Migration[6.1]
  DEFAULT_ROLE = Constants::Roles::General::DEFAULT
  def change
    create_table :roles do |t|
      t.references :created_by, null: true, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: true

      t.string :name, null: false, default: DEFAULT_ROLE

      t.index %i[name user_id], unique: true
      t.timestamps
    end
  end
end
