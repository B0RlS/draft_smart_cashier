# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class InvalidProductCodeError < ValidationError
    def initialize
      super('Invalid product code')
    end
  end
end
