require 'rails_helper'

RSpec.describe Hangar, type: :model do
  it { should have_many(:products) }
  it { should validate_presence_of :number }

  let(:hangar) { create(:hangar) }
  let(:product) { create(:product, hangar: hangar) }
  let!(:item1) { create(:item, product: product) }
  let!(:item2) { create(:item, product: product) }

  describe '#sum_wieght' do
    it 'calculate sum of items wi