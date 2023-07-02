RSpec.describe Repository::ProductRepository do
  subject { described_class.new }

  let(:product_service) { Services::ProductService.new }
  let(:product) { product_service.add_product('GT1', 'Green Tea', 3.11) }

  describe '#add_product' do
    it 'adds a product to the repository', :aggregate_failures do
      expect { subject.add_product(product) }.to change { subject.products.count }.by(1)
      expect(subject.products.last).to eq(product)
    end
  end
end
