# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationMembership, type: :model do
  it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:organization_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:created_by_id).of_type(:integer).with_options(null: true) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it { should have_db_index(%i[user_id organization_id]).unique }

  it {
    should belong_to(:created_by)
      .optional
  }

  it {
    should belong_to(:user)
      .inverse_of(:organization_memberships)
  }

  it {
    should belong_to(:organization)
      .inverse_of(:organization_memberships)
  }
end
