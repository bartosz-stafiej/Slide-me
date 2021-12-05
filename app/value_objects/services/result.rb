# frozen_string_literal: true

module Services
  class Result
    attr_reader :output, :error

    def initialize(output:, error: nil)
      @output = output
      @error = error
    end

    def failure?
      !success?
    end

    def success?
      error.nil?
    end
  end
end
