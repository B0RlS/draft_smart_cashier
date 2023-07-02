# frozen_string_literal: true

require_relative '../../errors/invalid_product_price_error'

module Services
  module Discounts
    class BuyOneGetOneFree
      class << self
        def applicable?(quantity)
          quantity > 1
        end

        def calculate_discount_price(product_info)
          raise Errors::NotApplicableDiscountError unless applicable?(product_info[:quantity])

          product_info[:price] * full_price_quantity(product_info[:quantity])
        end

        private

        def full_price_quantity(quantity)
          quantity - (quantity / 2)
        end
      end
    end
  end
end
