# frozen_string_literal: true

Shoulda::Matchers.configure do |c|
  c.integrate do |with|
    with.test_framework :rspec

    # Keep as many of these lines as are necessary:
    with.library :active_record
    with.library :active_model
  end
end
