require 'rails_helper'

feature 'Create product', %q{
  as an authenticated user
  I need to be able to create products
} do

  given(:admin_user