# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { should have_db_index(:email).unique }

  it {
    should have_many(:created_categories)
      .class_name(:Category)
      .dependent(:nullify)
      .inverse_of(:creator)
  }
end
