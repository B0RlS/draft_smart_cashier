# frozen_string_literal: true

class TotalAmountPresenter
  def initialize(total_amount)
    @total_amount = total_amount
  end

  def present
    puts amount
  end

  private

  attr_reader :total_amount

  def amount
    total_amount.format(symbol: '£', thousands_separator: ',', decimal_mark: '.')
  end
end
