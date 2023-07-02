# frozen_string_literal: true

module Errors
  class ValidationError < StandardError
    def initialize(msg = 'Validation Error Occurred')
      super
    end
  end
end
