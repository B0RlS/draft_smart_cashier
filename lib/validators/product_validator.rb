# frozen_string_literal: true

require_relative '../errors/invalid_product_code_error'
require_relative '../errors/invalid_product_price_error'
require_relative '../errors/empty_product_attributes_error'

module Validators
  class ProductValidator
    VALID_PRODUCT_CODE_REGEX = /\A[a-zA-Z0-9]+\z/

    def self.validate!(product_code, name, price)
      validate_presence(product_code, name, price)
      validate_product_price(price)
      validate_product_code(product_code)
    end

    def self.validate_product_code!(product_code)
      validate_product_code(product_code)
    end

    def self.validate_product_price(price)
      raise Errors::InvalidProductPriceError unless price_valid?(price)
    end

    def self.validate_presence(product_code, name, price)
      return unless name.empty? || product_code.empty? || price.nil?

      raise Errors::EmptyProductAttributesError
    end

    def self.validate_product_code(product_code)
      return unless product_code.empty? || !product_code.match(VALID_PRODUCT_CODE_REGEX)

      raise Errors::InvalidProductCodeError
    end

    def self.price_valid?(price)
      price.is_a?(Numeric) && !price.nil? && price.positive?
    end
  end
end
