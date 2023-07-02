RSpec.describe Data::Model::Product do
  subject { described_class.new(product_code, name, price) }

  let(:product_code) { 'P1' }
  let(:name) { 'Green tea' }
  let(:price) { 3.11 }

  describe '#initialize' do
    context 'when all attributes are valid', :aggregate_failures do
      it 'creates a new product with correct attributes' do
        expect(subject.product_code).to eq('P1')
        expect(subject.name).to eq('Green tea')
        expect(subject.price).to eq(Money.new(311, 'GBP'))
      end
    end
  end
end

