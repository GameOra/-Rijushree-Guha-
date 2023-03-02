require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:hangar) }
  it { should have_many(:items) }
  it { should have_many(:transactions) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should valid