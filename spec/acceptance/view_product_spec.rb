require 'rails_helper'

feature 'View product', %q{
  I need to be able to view product
} do
  given(:user) { create(:user) }
  # given(:product) { create(:product_with_comments) }
  given(:product) { create(:product) }

  context 'Authenticated user' do
    scenario 'sees the product' do
      sign_in(user)
      visit product_path(product)

      wit