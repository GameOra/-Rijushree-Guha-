require 'rails_helper'

feature 'User deletes product', %q{
  User can delete product
} do

  given(:user) { create(:user) }

  given(:product