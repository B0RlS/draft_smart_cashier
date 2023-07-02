# frozen_string_literal: true

require_relative '../errors/invalid_discount_error'
require_relative '../services/discount_rule_service'

module Validators
  class DiscountValidator
    AVAILABLE_DISCOUNTS = Services::DiscountRuleService::AVAILABLE_DISCOUNTS.keys.freeze

    def self.validate!(rule_name)
      validate_discount_name(rule_name)
    end

    def self.validate_discount_name(name)
      raise Errors::InvalidDiscountError unless AVAILABLE_DISCOUNTS.include?(name)
    end
  end
end
