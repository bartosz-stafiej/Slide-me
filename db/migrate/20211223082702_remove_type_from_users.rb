# frozen_string_literal: true

class RemoveTypeFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :type, :string, null: true
  end
end
