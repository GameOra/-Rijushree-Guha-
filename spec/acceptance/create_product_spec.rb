require 'rails_helper'

feature 'Create product', %q{
  as an authenticated user
  I need to be able to create products
} do

  given(:admin_user) { create(:user) }
  given(:contractor_user) { create(:user) }
  given(:seller_user) { create(:user) }
  given!(:hangar) { create(:hangar) }

  describe 'Admin user' do
    before { admin_user.add_role(:admin) }
    scenario 'creates product' do
      sign_in(admin_user)

      click_new_product_link
      fi