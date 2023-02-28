
require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity) }

  let(:item) { create(:item, quantity: 3) }

  describe '#calculate_total_wieght' do
    it 'should calculate total_wieght' do
      expect(item.total_wieght).to eq(item.product.wieght * 3)
    end
  end

  describe '#add' do
    it 'should adds up item.quantity with parametr' do
      expect(item.add(10)).to eq(13)
    end
  end
end