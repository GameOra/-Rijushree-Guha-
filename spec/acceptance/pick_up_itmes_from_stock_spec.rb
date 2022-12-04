
require 'rails_helper'

feature 'Pick up item', %q{
  as an seller user
  I need to be able to pick up itmes from the stock
} do

  given(:user) { create(:user) }
  given!(:product) { create(:product) }
  given(:item) { create(:item, product: product, quantity: 10) }

  describe 'Seller user picks up item' do
    before { user.add_role(:seller) }
    scenario 'it decreases quantity of item' do
      sign_in(user)

      visit item_path(item)
      click_on 'Забрать товар со склада'
      select product.name, from: 'item_product_id'
      fill_in 'item_quantity', with: '5'
      click_on 'Сохранить'

      expect(page).to have_content product.name
      expect(page).to have_content '5'
      expect(page).to have_content product.wieght * 5
      expect(page).to have_content product.hangar.number
    end
  end

  describe 'Contractor user does not pick up item' do
    before { user.add_role(:contractor) }
    scenario 'it decreases quantity of item' do
      sign_in(user)

      visit item_path(item)

      expect(page).to_not have_content 'Забрать товар со склада'
    end
  end

  scenario 'Unauthenticated user tries to pick up item' do
    visit item_path(item)
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end