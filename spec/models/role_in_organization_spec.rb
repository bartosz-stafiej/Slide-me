# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleInOrganization, type: :model do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:added_by_id).of_type(:integer).with_options(null: true) }

  it { should have_db_index(%i[name organization_membership_id]).unique }

  it {
    should belong_to(:organization_membership)
      .inverse_of(:roles_in_organization)
  }

  it {
    should belong_to(:added_by)
      .inverse_of(:roles_in_organization_created)
      .class_name(:User)
      .optional
  }
end
