
require 'rails_helper'

feature 'Product editing', %q{
  In order to fix mistake
  as an author of product
  I'd like to be able to edit product
} do

  given(:user) { create(:user) }
  given!(:product) { create(:product) }
  given(:hangar) { create(:hangar) }

  scenario 'Unuthenticated user tries to edit product' do
    visit product_path(product)

    expect(page).to_not have_link 'Изменить'
  end

  describe 'Admin user' do
    before { user.add_role(:admin) }

    scenario 'tries to edit product' do
      sign_in(user)
      visit product_path(product)

      click_on 'Изменить'
      fill_in 'product_name', with: 'edited product name'
      fill_in 'product_wieght', with: '111'
      select hangar.number, from: 'product_hangar_id'
      click_on 'Сохранить'

      expect(page).to_not have_content product.name
      expect(page).to have_content 'edited product name'
      expect(page).to have_content '111'
      expect(page).to_not have_link 'Сохранить'
    end
  end

  describe 'Contractor user' do
    before { user.add_role(:contractor) }

    scenario 'tries to edit product' do
      sign_in(user)
      visit product_path(product)

      expect(page).to_not have_content 'Изменить'
    end
  end

  describe 'Seller user' do
    before { user.add_role(:seller) }

    scenario 'tries to edit product' do
      sign_in(user)
      visit product_path(product)

      expect(page).to_not have_content 'Изменить'
    end
  end
end