
require 'rails_helper'

feature 'View admin panel', %q{
  As an administator
  I need to be able view admin dashboard
} do
  given(:user) { create(:user) }
  given(:product) { create(:product) }
  given!(:items) { create_list(:item, 10) }
  given(:item) { create(:item, product: product, quantity: 20) }

  context 'Admin' do
    before { user.add_role(:admin) }
    scenario 'sees the dashboard' do
      sign_in(user)
      visit admin_items_path

      within '.items' do
        expect(page).to have_content items.first.product.name
        expect(page).to have_content items.last.product.name
        # expect(page).to have_content item.product.hangar.number
      end
    end
  end

  context 'Unauthenticated user' do
    scenario 'does not see the item' do
      visit admin_items_path

      expect(page).to_not have_content items.first.product.name
      expect(page).to_not have_content items.last.product.name
    end
  end
end