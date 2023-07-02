# frozen_string_literal: true

require_relative '../../errors/invalid_product_price_error'

module Services
  module Discounts
    class Percentage
      class << self
        def applicable?(quantity)
          quantity >= 3
        end

        def calculate_discount_price(product_info)
          raise Errors::NotApplicableDiscountError unless applicable?(product_info[:quantity])

          product_info[:quantity] * two_thirds_of_price(product_info[:price])
        end

        private

        def two_thirds_of_price(price)
          (price / 3) * 2
        end
      end
    end
  end
end
