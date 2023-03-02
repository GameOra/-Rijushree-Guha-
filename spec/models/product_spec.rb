require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:hangar) }
  it { should have_many(:items) }
  it { should have_many(:transactions) }

  it { s