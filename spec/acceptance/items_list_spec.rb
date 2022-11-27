require 'rails_helper'

feature 'List items', %q{
  In order to find the item in stock
  I need to be able to view list of items
} do
    given(:user) { create(:user) }
    given(:products) { create_list(:product, 2) }
    given!(:first_item) { create(:item, product: products.first) }
    given!(:second_item) { create(:item, product: products.last) }

    scenario 'Authenticated user views list of items' do
      sign_in(user)
      visit items_path

      exp