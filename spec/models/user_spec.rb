require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:transactions) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :name }

  let(:user) { create(:user) }

  describe '#set_role' do
    before do
      user.add_role(:seller)
      user.add_role(:contractor)
      user.set_role(Role.find_by(name: :contractor))
    end

    it 'set new role' do
      expect(user.has_role?(:contractor)).to be_truthy
    end

    it 'remove old role' do
      expect(user.has_role?(:seller)).to be_falsy
    end
  end
end
