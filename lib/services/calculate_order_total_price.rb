# frozen_string_literal: true

module Services
  class CalculateOrderTotalPrice
    def initialize(order, discount_rules)
      @order = order
      @discount_rules = discount_rules
      @discount_cache = {}
    end

    def call
      order.items.each { |product_code, product_info| calculate_product_total_price(product_code, product_info) }
      order.total
    end

    private

    attr_reader :order, :discount_rules, :discount_cache

    def calculate_product_total_price(product_code, product_info)
      discounts = eligible_discounts(product_code)

      if discounts.empty?
        order.total += calculate_regular_price(product_info)
      else
        calculate_price_with_discount(product_info, discounts)
      end
    end

    def calculate_price_with_discount(product_info, discounts)
      potential_prices = discounts.map { |discount| calculate_potential_price(discount, product_info) }
      order.total += potential_prices.min
    end

    def calculate_potential_price(discount, product_info)
      if discount.applicable?(product_info[:quantity])
        calculate_discount_price(discount, product_info)
      else
        calculate_regular_price(product_info)
      end
    end

    def calculate_discount_price(discount, product_info)
      discount.calculate_discount_price(product_info)
    end

    def calculate_regular_price(product_info)
      product_info[:price] * product_info[:quantity]
    end

    def eligible_discounts(product_code)
      discount_cache[product_code] ||= discount_rules.eligible_discounts(product_code)
    end
  end
end
