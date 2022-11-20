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

      expect(page).to have_no_content product.name
    end
  end

  describe 'Seller user' do
    before { user.add_role(:seller) }
    scenario 'does not delete product' do
      sign_in(user)

      visit product_path(product)
      expect(page).to have_no_content 'Удалить'
    end
  end

  describe 'Contractor user' do
    before { user.add_role(:contractor) }
    scenario 'does not delete product' do
      sign_in(user)

      visit product_path(product)
      expect(page).to have_no_content 'Удалить'
    end
  end

  scenario 'Unauthenticated user tries to delete product' do
    visit product_path(product)

    expect(page).to have_no_content 'Удалить'
  end
end
