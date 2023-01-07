require 'rails_helper'

feature 'View item', %q{
  I need to be able to view item
} do
  given(:user) { create(:user) }
  given(:product) { create(:product) }
  given(:item) { create(:item, product: product, quantity: 3) }

  context 'Admin user' do
    before { user.add_role(:admin) }
    scenario 'sees the item' do
      sign_in(user)
      visit item_path(item)

      within '.item' do
        expect(page).to have_content 'MyString'
        expect(page).to have_content '9.99'
        expect(page).to have_content '3'
        expect(page).to have_content 9.99*3
        expect(page).to have_content item.product.hangar.number
      end
    end
  end

  context 'Seller user' do
    before { user.add_role(:seller) }
    scenario 'sees the item' do
      sign_in(user)
      visit item_path(item)

      within '.item' do
        expect(page).to have_content 'MyString'
        expect(page).to have_content '9.99'
        expect(page).to have_content '3'
        expect(page).to have_content 9.99*3
        expect(page).to have_content item.product.hangar.number
      end
    end
  end

  context 'Contractor user' do
    before { user.add_role(:contractor) }
    scenario 'sees the item' do
      sign_in(user)
      visit item_path(item)

      within '.item' do
        expect(page).to have_content 'MyString'
        expect(page).to have_content '9.99'
        expect(page).to have_content '3'
        expect(page).to have_content 9.99*3
        expect(page).to have_content item.product.hangar.number
      end
    end
  end

  context 'Unauthenticated user' do
    scenario 'does not see the item' do
      visit item_path(item)

      expect(page).to_not have_content 'MyString'
      expect(page).to_not have_content '9.99'
      expect(page).to_not have_content "Ангар: #{item.product.ha