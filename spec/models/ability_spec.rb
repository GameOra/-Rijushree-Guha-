require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user) }
    before { user.add_role(:admin) }

    it { should be_able_to :manage, :all }
  end

  describe 'for seller' do
    let(:user) { create(:user) }
    before { user.add_role(:seller) }

    it { should be_able_to :create, Transact