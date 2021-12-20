# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:created_by_id).of_type(:integer).with_options(null: true) }

  it { should have_db_index(%i[name user_id]).unique }

  it {
    should belong_to(:user)
      .inverse_of(:roles)
  }

  it {
    should belong_to(:created_by)
      .inverse_of(:created_roles)
      .optional
  }
end
