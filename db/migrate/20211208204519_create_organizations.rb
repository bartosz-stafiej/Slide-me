# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :identifier, null: true

      t.index :identifier, unique: true
      t.index :name, unique: true
      t.timestamps
    end
  end
end
