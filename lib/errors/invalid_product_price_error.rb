# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class InvalidProductPriceError < ValidationError
    def initialize
      super('Invalid product price. Price should be Numeric and greater then 0')
    end
  end
end
