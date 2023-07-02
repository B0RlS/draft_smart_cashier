# frozen_string_literal: true

require_relative '../../errors/invalid_product_price_error'

module Services
  module Discounts
    class Dynamic
      SPECIAL_PRICE = Money.new(450, 'GBP').freeze

      class << self
        def applicable?(quantity)
          quantity >= 3
        end

        def calculate_discount_price(product_info)
          raise Errors::NotApplicableDiscountError unless applicable?(product_info[:quantity])

          SPECIAL_PRICE * product_info[:quantity]
        end
      end
    end
  end
end
