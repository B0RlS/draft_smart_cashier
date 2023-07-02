RSpec.describe Validators::DiscountValidator do
  subject { described_class.validate!(discount_name) }

  describe '.validate!' do
    context 'when discount name is valid' do
      let(:discount_name) { 'buy_one_get_one_free' }

      it "doesn't raises an error" do
        expect {subject}.not_to raise_error
      end
    end

    context 'when discount name is invalid' do
      let(:discount_name) { 'half_price' }

      it 'raises an InvalidDiscountError' do
        expect {subject}.to raise_error(Errors::InvalidDiscountError)
      end
    end
  end
end
