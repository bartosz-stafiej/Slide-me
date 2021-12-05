# frozen_string_literal: true

module ParseHelper
  def parse(string)
    JSON.parse(string)
  end
end

RSpec.configure do |config|
  config.include ParseHelper, type: :request
end
