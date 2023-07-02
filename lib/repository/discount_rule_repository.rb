# frozen_string_literal: true

module Repository
  class DiscountRuleRepository
    attr_reader :rules

    def initialize
      @rules = Hash.new { |rules, discount_name| rules[discount_name] = [] }
    end

    def add_rule(discount_name, product_code)
      rules[discount_name] << product_code
    end

    def remove_rule(discount_name, product_code)
      return unless rules[discount_name]

      rules[discount_name].delete(product_code)
      rules.delete(discount_name) if rules[discount_name].empty?
    end

    def eligible_discounts(product_code)
      rules.select { |_, product_codes| product_codes.include?(product_code) }.keys
    end
  end
end
