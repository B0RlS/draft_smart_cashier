# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class InvalidDiscountError < ValidationError
    def initialize
      super('Invalid discount name. Check available discounts')
    end
  end
end
