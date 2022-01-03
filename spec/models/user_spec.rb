# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { should have_db_column(:first_name).of_type(:string).with_options(null: true) }
  it { should have_db_column(:last_name).of_type(:string).with_options(null: true) }
  it { should have_db_index(:email).unique }

  it {
    should have_many(:organizations)
      .through(:organization_memberships)
      .inverse_of(:users)
      .dependent(:nullify)
  }

  it {
    should have_many(:roles)
      .inverse_of(:user)
      .dependent(:destroy)
  }

  it {
    should have_many(:created_memberships)
      .class_name(:OrganizationMembership)
      .inverse_of(:created_by)
      .dependent(:nullify)
  }

  it {
    should have_many(:created_roles)
      .class_name(:Role)
      .inverse_of(:created_by)
      .dependent(:nullify)
  }

  it {
    should have_many(:created_categories)
      .class_name(:Category)
      .inverse_of(:creator)
      .dependent(:nullify)
  }

  it {
    should have_many(:roles_in_organization_created)
      .class_name(:RoleInOrganization)
      .inverse_of(:added_by)
      .dependent(:nullify)
  }

  it {
    should have_one(:address).dependent(:destroy)
  }
end
