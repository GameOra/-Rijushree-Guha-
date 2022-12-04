
require 'rails_helper'

feature 'Products list', %q{
  In order to find the specific product,
  the user should have the opportunity
  to view the list of products
} do
  given!(:products) { create_list(:product, 2) }
  given(:user) { create(:user) }

  scenario 'Authenticated user views list of products' do
    sign_in(user)
    visit products_path

    expect(page).to have_content products.first.name
    expect(page).to have_content products.last.name
  end

  scenario 'Unauthenticated user tries to see list of products' do
    visit products_path

    expect(page).to_not have_content products.first.name
    expect(page).to_not have_content products.last.name
  end
end