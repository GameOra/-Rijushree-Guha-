require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:transactions) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :name }

  let(:user) { create(:user) }

  describe '#set_role' do
    before do
      user.add_role(:sell