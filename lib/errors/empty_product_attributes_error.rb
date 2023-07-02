# frozen_string_literal: true

require_relative 'validation_error'

module Errors
  class EmptyProductAttributesError < ValidationError
    def initialize
      super('Product attributes are empty')
    end
  end
end
