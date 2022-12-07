require 'rails_helper'

feature 'View item', %q{
  I need to be able to view item
} do
  given(:user) { create(:user) }
  given(:product) { create(:product)