# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, null: true
    add_column :users, :last_name, :string, null: true
  end
end
