# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { should have_db_column(:organization_id).of_type(:integer).with_options(null: true) }
  it { should have_db_index(:email).unique }

  it { should belong_to(:organization).inverse_of(:organization_members).optional }
end
