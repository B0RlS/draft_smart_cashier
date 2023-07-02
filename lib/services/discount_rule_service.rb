# frozen_string_literal: true

require_relative 'discounts/percentage'
require_relative 'discounts/dynamic'
require_relative 'discounts/buy_one_get_one_free'

module Services
  class DiscountRuleService
    AVAILABLE_DISCOUNTS = {
      'buy_one_get_one_free' => Discounts::BuyOneGetOneFree,
      'dynamic'              => Discounts::Dynamic,
      'percentage'           => Discounts::Percentage
    }.freeze

    attr_reader :discount_rule_repository

    def initialize(discount_rule_repository = Repository::DiscountRuleRepository.new)
      @discount_rule_repository = discount_rule_repository
    end

    def add_discount_rule(discount_name, product_code)
      validate_data(discount_name, product_code)

      discount_rule_repository.add_rule(discount_name, product_code)
    end

    def remove_discount_rule(discount_name, product_code)
      validate_data(discount_name, product_code)

      discount_rule_repository.remove_rule(discount_name, product_code)
    end

    def eligible_discounts(product_code)
      discount_rule_repository.eligible_discounts(product_code).
        map { |discount_name| AVAILABLE_DISCOUNTS[discount_name] }
    end

    private

    def validate_data(discount_name, product_code)
      Validators::DiscountValidator.validate!(discount_name)
      Validators::ProductValidator.validate_product_code!(product_code)
    end
  end
end
