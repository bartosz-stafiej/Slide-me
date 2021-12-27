# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:creator_id).of_type(:integer).with_options(null: true) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:creator)
      .class_name(:User)
      .inverse_of(:created_categories)
      .optional
  }

  it { should have_db_index(:name).unique }
end
