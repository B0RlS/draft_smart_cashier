# frozen_string_literal: true

RSpec.describe TotalAmountPresenter do
  subject { described_class.new(money_object) }

  let(:money_object) { Money.new(3680, 'GBP') }

  describe '#present' do
    it 'returns the formatted total amount' do
      expect { subject.present }.to output("£36.80\n").to_stdout
    end
  end
end
