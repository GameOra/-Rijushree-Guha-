require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    