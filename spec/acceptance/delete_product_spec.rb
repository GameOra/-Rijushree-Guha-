require 'rails_helper'

feature 'User deletes product', %q{
  User can delete product
} do

  given(:user) { create(:user) }

  given(:product) { create(:product) }

  describe 'Admin user' do
    before { user.add_role(:admin) }
    scenario 'deletes product' do
      sign_in(user)

      visit product_path(product)
      click_on 'Удалить'

      expect(page).to h