# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :creator, null: true, foreign_key: { to_table: :users }

      t.timestamps

      t.index :name, unique: true
    end
  end
end
