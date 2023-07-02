# frozen_string_literal: true

require 'require_all'
require_all 'lib'

# Initialize Product Service for creating products
product_service = Services::ProductService.new

# Initializing Products
product1 = product_service.add_product('GR1', 'Green tea', 3.11)
product2 = product_service.add_product('SR1', 'Strawberries', 5.00)
product3 = product_service.add_product('CF1', 'Coffee', 11.23)

# Initialize Discount Service for creating discount rules
discount_rules = Services::DiscountRuleService.new

# Add discount rules
discount_rules.add_discount_rule('buy_one_get_one_free', 'GR1')
discount_rules.add_discount_rule('dynamic', 'SR1')
discount_rules.add_discount_rule('percentage', 'CF1')

# Initializing Checkout
checkout = Services::Checkout.new(discount_rules)

# Adding Products to Order
3.times { checkout.scan(product1) }
5.times { checkout.scan(product2) }
4.times { checkout.scan(product3) }

# Show Total Price
TotalAmountPresenter.new(checkout.total_amount).present
