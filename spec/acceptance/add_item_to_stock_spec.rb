
require 'rails_helper'

feature 'Add item', %q{
  as an authenticated user
  I need to be able to add itmes to the stock
} do

  given(:user) { create(:user) }
  given!(:product) { create(:product) }

  describe 'Admin user adds item' do
    given(:admin_user) { create(:user) }
    before { admin_user.add_role(:admin) }

    scenario 'it creates new item if item does not exists on the stock' do
      sign_in(admin_user)
      click_new_item_link

      select product.name, from: 'item_product_id'
      fill_in 'item_quantity', with: '10'
      click_on 'Сохранить'

      expect(page).to have_content product.name
      expect(page).to have_content '10'
      expect(page).to have_content product.wieght * 10
      expect(page).to have_content product.hangar.number
    end

    describe 'if item exists' do
      given!(:item) { create(:item, product: product, quantity: '10') }

      scenario 'it does not create new one but increases quantity of item' do
        sign_in(admin_user)

        click_new_item_link
        select product.name, from: 'item_product_id'
        fill_in 'item_quantity', with: '10'
        click_on 'Сохранить'

        expect(page).to have_content product.name
        expect(page).to have_content '20'
        expect(page).to have_content product.wieght * 20
        expect(page).to have_content product.hangar.number
      end
    end

    scenario 'Admin user tries to create item with blank fields' do
      sign_in(admin_user)

      click_new_item_link
      click_on 'Сохранить'

      expect(page).to have_content "Product must exist"
    end

    scenario 'Unauthenticated user tries to create item' do
      visit items_path
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

  end


  describe 'Contractor user adds item' do
    given(:contractor_user) { create(:user) }
    before { contractor_user.add_role(:contractor) }

    scenario 'it creates new item if item does not exists on the stock' do
      sign_in(contractor_user)
      click_new_item_link

      select product.name, from: 'item_product_id'
      fill_in 'item_quantity', with: '10'
      click_on 'Сохранить'

      expect(page).to have_content product.name
      expect(page).to have_content '10'
      expect(page).to have_content product.wieght * 10
      expect(page).to have_content product.hangar.number
    end
  end

  describe 'Seller user tries to add item' do
    given(:seller_user) { create(:user) }
    before { seller_user.add_role(:seller) }

    scenario 'it does not create new item on the stock' do
      sign_in(seller_user)
      visit items_path
      expect(page).to_not have_content 'Добавить товар на склад'
    end
  end

  private

  def click_new_item_link
    visit items_path
    click_on 'Добавить товар на склад'
  end
end