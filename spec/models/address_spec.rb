# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should have_db_column(:addressable_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:addressable_type).of_type(:string).with_options(null: false) }

  it { should have_db_column(:post_code).of_type(:string).with_options(null: false) }
  it { should have_db_column(:country).of_type(:string).with_options(null: false) }
  it { should have_db_column(:city).of_type(:string).with_options(null: false) }
  it { should have_db_column(:address_line).of_type(:string).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
end
