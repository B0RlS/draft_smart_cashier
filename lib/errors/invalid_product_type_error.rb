# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class InvalidProductPriceError < ValidationError
    def initialize
      super('Invalid product type. The passed object is not a Product object')
    end
  end
end
