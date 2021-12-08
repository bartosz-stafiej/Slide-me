# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true, null: false

      t.string :post_code, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :address_line, null: false

      t.timestamps
    end
  end
end
