require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :read, :all }
    it { should_not be_able_to :mana