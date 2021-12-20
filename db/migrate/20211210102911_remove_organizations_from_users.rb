# frozen_string_literal: true

class RemoveOrganizationsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :organization, null: true, foreign_key: true
  end
end
