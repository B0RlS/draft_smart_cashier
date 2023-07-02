# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class NotApplicableDiscountError < ValidationError
    def initialize
      super('Quantity of produts are not eligible for discount application')
    end
  end
end
