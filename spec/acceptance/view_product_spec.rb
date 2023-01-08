require 'rails_helper'

feature 'View product', %q{
  I need to be able to view product
} do
  given(:user) { create(:user) }
  # given(:product) { create(:pro