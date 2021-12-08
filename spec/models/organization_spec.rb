# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:identifier).of_type(:string).with_options(null: true) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it { should have_db_index(:identifier).unique }
  it { should have_db_index(:name).unique }

  it { should have_one(:address) }

  it {
    should have_many(:organization_members)
      .class_name(:User)
      .inverse_of(:organization)
      .dependent(:nullify)
  }
end
