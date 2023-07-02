describe Services::DiscountRuleService do
  subject { described_class.new(Repository::DiscountRuleRepository.new) }

  let(:discount_name) { 'buy_one_get_one_free' }
  let(:product_code) { 'SR1' }

  describe '#add_discount_rule' do
    context 'when attributes for adding discount rule are valid' do
      it 'adds a discount rule' do
        expect { subject.add_discount_rule(discount_name, product_code) }.to change { subject.eligible_discounts(product_code).count }.by(1)
      end
    end

    context 'when discount name is not valid' do
      let(:invalid_discount_name) {'invalid_discount'}

      it 'raises an error' do
        expect { subject.add_discount_rule(invalid_discount_name, product_code) }.to raise_error(Errors::InvalidDiscountError)
      end
    end

    context 'when product code is not valid' do
      let(:invalid_product_code) { '@invalid_product_code' }

      it 'raises an error' do
        expect { subject.add_discount_rule(discount_name, invalid_product_code) }.to raise_error(Errors::InvalidProductCodeError)
      end
    end
  end

  describe '#remove_discount_rule' do
    before { subject.add_discount_rule(discount_name, product_code) }

    context 'when the rule exists' do
      it 'removes a discount rule' do
        expect { subject.remove_discount_rule(discount_name, product_code) }.to change { subject.eligible_discounts(product_code).count }.by(-1)
      end
    end

    context 'when the rule does not exist' do
      let(:non_existent_discound_name) { 'dynamic' }

      it 'does not change the rules' do
        expect { subject.remove_discount_rule(non_existent_discound_name, product_code) }.not_to change { subject.eligible_discounts(product_code).count }
      end
    end
  end

  describe '#eligible_discounts' do
    before { subject.add_discount_rule(discount_name, product_code) }

    it 'returns the eligible discounts for a product' do
      expect(subject.eligible_discounts(product_code)).to eq([Services::Discounts::BuyOneGetOneFree])
    end
  end
end
